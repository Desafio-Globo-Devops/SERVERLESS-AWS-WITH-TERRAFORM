'use strict'

const AWS = require('aws-sdk')
AWS.config.region = process.env.AWS_REGION 

const docClient = new AWS.DynamoDB.DocumentClient()
const uuidv4 = require('uuid/v4')
const { getS3object, putS3object }  = require('./s3')

const ddbTable = process.env.DDBtable 

exports.handler = async (event) => {
  const records = event.Records
  console.log (JSON.stringify(event, null, 2))
  console.log('Using DDB table: ', ddbTable)

  try {
    await Promise.all(
      records.map(async (record) => {
        console.log('Incoming record: ', record)

        // Get original text from object in incoming event
        const originalText = await getS3object({
          Bucket: event.Records[0].s3.bucket.name,
          Key: event.Records[0].s3.object.key
        })

        // Upload JSON to DynamoDB
        const jsonData = JSON.parse(originalText.Body.toString('utf-8'))
        const ddbResult = await uploadJSONtoDynamoDB(jsonData)
      
        console.log ('DDBresult: ', ddbResult)
      })
    )
  } catch (err) {
    console.error(err)
  }
}

const uploadJSONtoDynamoDB = async (data) => {

  // Separate into batches for upload
  let batches = []
  const BATCH_SIZE = 25

  while (data.length > 0) {
    batches.push(data.splice(0, BATCH_SIZE))
  }

  console.log('Batches: ', batches.length)

  let batchCount = 0

  // Save each batch
  await Promise.all(
    batches.map(async (item_data) => {

      // Set up the params object for the DDB call
      const params = {
        RequestItems: {}
      }
      params.RequestItems[ddbTable] = []
  
      item_data.forEach(item => {
        for (let key of Object.keys(item)) {
          // An AttributeValue may not contain an empty string
          if (item[key] === '') 
            delete item[key]
        }

        // Build params
        params.RequestItems[ddbTable].push({
          PutRequest: {
            Item: {
              ID: uuidv4(),
              ...item
            }
          }
        })
      })

      // Push to DynamoDB in batches
      try {
        batchCount++
        console.log('Trying batch: ', batchCount)
        const result = await docClient.batchWrite(params).promise()
        console.log('Success: ', result)
      } catch (err) {
        console.error('Error: ', err)
      }
    })
  )
}
