require 'coffee-script/register'
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'github membership', ->
  beforeEach ->
    @robot =
      hear: sinon.spy()

    require('../src/github-membership')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.hear).to.have.been.calledWith(/add (.*) to Github/i)

