const getStdin = require('get-stdin')

const handler = require('./handler.js')

const runHandler = async () => {
  const str = await getStdin()
  let body
  try {
    body = JSON.parse(str)
  } catch (err) {
    body = str
  }

  handler({ body })
}

runHandler(handler)
