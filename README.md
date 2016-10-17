# hubot-soccer

Fetches live soccer scores

See [`src/soccer.coffee`](src/soccer.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-soccer --save`

Then add **hubot-soccer** to your `external-scripts.json`:

```json
[
  "hubot-soccer"
]
```

## Sample Interaction

```
user1>> hubot soccer
hubot>> Spanish Primera Division: FC Barcelona 5 0 Malaga
```

## Notes
This plugin is powered by https://soccer-cli.appspot.com/. Refer to https://github.com/architv/soccer-cli/ for more details
