import 'dart:io';
import 'package:auto_chat_action/auto_chat_action.dart';
import 'package:televerse/televerse.dart';

final bot = Bot(Platform.environment["BOT_TOKEN"]!);

void main() {
  bot.use(AutoChatAction());

  final keyboard = Keyboard()
      .text("Photo")
      .text("Video")
      .row()
      .text("Voice")
      .text("Document")
      .resized();

  Future<void> startHandler(Context ctx) async {
    await ctx.reply(
      "Hello, choose a type of file from the buttons.",
      replyMarkup: keyboard,
    );
  }

  bot.command('start', startHandler);
  bot.onMessage(startHandler);

  bot.text("Voice", (ctx) async {
    await ctx.replyWithVoice(
      InputFile.fromUrl(getUrl("audio")),
      caption: thanks,
      parseMode: ParseMode.html,
    );
  });

  bot.text("Video", (ctx) async {
    await ctx.replyWithVideo(
      InputFile.fromUrl(getUrl("video")),
      caption: thanks,
      parseMode: ParseMode.html,
    );
  });

  bot.text("Photo", (ctx) async {
    await ctx.replyWithPhoto(
      InputFile.fromUrl(getUrl("photo")),
      caption: thanks,
      parseMode: ParseMode.html,
    );
  });

  bot.text("Document", (ctx) async {
    await ctx.replyWithDocument(
      InputFile.fromUrl(getUrl("document")),
      caption: thanks,
      parseMode: ParseMode.html,
    );
  });

  bot.start();
}

// Globals

const base = "https://televerse-space.web.app/";
const fileMap = {
  "video": "example/video.mp4",
  "audio": "example/audio.mp3",
  "document": "example/document.pdf",
  "photo": "example/photo.jpg",
};

const thanks =
    'Credits to <a href="https://file-examples.com/">File Examples</a> for the file.';
// Get URL method that points to hosted example files
String getUrl(String file) {
  return "$base${fileMap[file]}";
}
