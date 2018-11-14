module.exports = (context) => {
  console.log(JSON.stringify({
    env: process.env,
    context
  }))
}
