# Description
#   Fetches live soccer scores
#
# Configuration:
#   request
#
# Commands:
#   hubot (soccer|football) - Fetches live football/soccer scores
#
# Author:
#   ravikiran.j.127@gmail.com

request = require "request"

module.exports = (robot) ->
    robot.respond /(soccer|football)/i, (msg) ->
        url = "https://soccer-cli.appspot.com/"
        request.get url, (error, response, data) ->
            if not response or response.statusCode != 200 or not data
                msg.send "There was an error fetching soccer/football scores"
                return

            try
                resp = responseHandler response, data, url
                msg.send resp
            catch error
                robot.logger.error error
                msg.send getErrorMsg url

    typeIsArray = Array.isArray || ( value   ) -> return {}.toString.call( value   ) is '[object Array]'

    getErrorMsg = (url) ->
        return "There was an error parsing soccer/football scores from url = #{url}"

    responseHandler = (response, data, url) ->
        resp = ""
        respArray = []
        data = JSON.parse(data)
        if not data.games? or not typeIsArray data.games
            return getErrorMsg url

        if data.games.length < 1
            return "There are no live soccer/football games currently being played"

        respArray.push "Live Scores"
        respArray.push "==========="
        for game in data.games
            if game.league? and game.goalsAwayTeam? and game.goalsHomeTeam? and game.time? and game.homeTeamName? and game.awayTeamName?
                goalsHome = if game.goalsHomeTeam < 0 then "" else game.goalsHomeTeam
                goalsAway = if game.goalsAwayTeam < 0 then "" else game.goalsAwayTeam
                g = "#{game.league}: #{game.homeTeamName} #{goalsHome} : #{goalsAway} #{game.awayTeamName} (#{game.time})"
                respArray.push g

        return respArray.join("\n")
