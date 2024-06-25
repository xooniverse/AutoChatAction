# AutoChatAction for Televerse

## Overview

`AutoChatAction` is a plugin for Televerse, a Telegram Bot API library in Dart,
that automatically sends chat actions like "typing..." or "uploading photo..."
based on the invoked method. This feature enhances user experience by indicating
ongoing bot activity.

## Installation

Add the `auto_chat_action` package to your project using Dart's package manager:

```bash
dart pub add auto_chat_action
```

## Usage

Using `AutoChatAction` is pretty simple. At first, create your Televerse bot
instance as always.

```dart
final bot = Bot(Platform.environment["BOT_TOKEN"]!);
```

Now, let's attach the `AutoChatAction` plugin to the bot. We can make use of the
`Bot.use` method for this.

```dart
  void main() {
    bot.use(AutoChatAction());

    // Rest of the code...
  }
```

Yeah, it's easy as one line :)

Now for every time you call one of `sendVideo`, `sendDocument`, `sendSticker`,
`sendVoice`, `sendMessage`, `sendLocation`, `sendVideoNote`, `sendPhoto` the
matching Chat Action is automatically send to the respective end user.

### Use it for only one context.

If, for some reason, you don't want to use the plugin for every API call and
prefer to apply it only within a specific context, you can attach the plugin to
the context using the `Context.use()` method instead of the `Bot.use()`.

```dart
bot.command('test', (ctx) async {
  ctx.use(AutoChatAction());

  // Rest of the code
});
```

### Configuration

The `AutoChatAction` class can be customized using the following properties:

- `allowedMethods`: A list of API methods that are allowed to send chat actions.
  Defaults to:
  ```dart
  [
    APIMethod.sendVideo, 
    APIMethod.sendDocument, 
    APIMethod.sendSticker, 
    APIMethod.sendVoice, 
    APIMethod.sendMessage, 
    APIMethod.sendLocation, 
    APIMethod.sendVideoNote, 
    APIMethod.sendPhoto, 
  ]
  ```
- `disallowedMethods`: A list of API methods that are not allowed to send chat
  actions. Defaults to an empty list.
- `interval`: The duration between repeated chat action sends. Defaults to 3
  seconds.

### Example Configuration

```dart
const autoChatAction = AutoChatAction(
  allowedMethods: [APIMethod.sendMessage, APIMethod.sendPhoto],
  disallowedMethods: [APIMethod.sendVoice],
  interval: Duration(seconds: 5),
);

bot.use(autoChatAction);
```

In this configuration, automatic chat actions will only be sent for
`sendMessage` and `sendPhoto` methods. The `sendVoice` method is explicitly
disallowed, and the interval between repeated actions is set to 5 seconds.

## Thank You

Thank you for using `AutoChatAction`! We hope this plugin enhances your bot
development experience with Televerse. If you encounter any issues or have
suggestions, feel free to contribute or raise an issue on the GitHub repository.
