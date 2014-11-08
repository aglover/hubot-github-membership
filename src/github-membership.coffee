# Description:
#   Adds user to Github Org team
#
# Dependencies:
#   
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#	HUBOT_DEFAULT_TEAM_ID
# 
# Commands:
#    add <username> to Github
#
# Author:
#   aglover
module.exports = (robot) ->
  robot.hear /add (.*) to Github/i, (msg) ->

    unless process.env.HUBOT_GITHUB_TOKEN?
      robot.logger.warning 'The HUBOT_GITHUB_TOKEN environment variable not set'

    teamId = process.env.HUBOT_DEFAULT_TEAM_ID
    userName = msg.match[1]
    msg.http("https://api.github.com/teams/#{teamId}/memberships/#{userName}")
    .headers(Authorization: "token #{process.env.HUBOT_GITHUB_TOKEN}", Accept: 'application/json').put() (err, res, body) ->
      if res.statusCode isnt 200
        console.log "error! #{res.statusCode} and err is #{err}"

      if res.statusCode is 200
        msg.send "user #{userName} added to Github!"



