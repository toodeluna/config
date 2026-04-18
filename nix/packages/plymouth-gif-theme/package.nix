{
  lib,
  stdenv,
  writeText,

  envsubst,
  ffmpeg,

  gif ? ../../../assets/gifs/maka-and-crona.gif,
  fps ? 16,
}:
let
  themeFile = writeText "plymouth-gif-theme.plymouth" ''
    [Plymouth Theme]
    Name=$pname
    Description=$description
    ModuleName=script

    [script]
    ImageDir=$out/share/plymouth/themes/plymouth-gif-theme/frames
    ScriptFile=$out/share/plymouth/themes/plymouth-gif-theme/plymouth-gif-theme.script
  '';

  scriptFile = writeText "plymouth-gif-theme.script" ''
    // Load frames
    frame_count = $frame_count;

    for (frame_index = 0; frame_index < frame_count; frame_index++) {
      frame_number = frame_index + 1;
      frame_path = "frame-" + frame_number + ".png";
      frames[frame_index] = Image(frame_path);
    }

    // Get center of screen
    screen_width = Window.GetWidth();
    screen_height = Window.GetHeight();

    image_width = frames[0].GetWidth();
    image_height = frames[0].GetHeight();

    center_x = (screen_width / 2) - (image_width / 2);
    center_y = (screen_height / 2) - (image_height / 2);

    // Create sprite
    sprite = Sprite();
    sprite.SetImage(frames[0]);
    sprite.SetPosition(center_x, center_y, 0);

    // Set refresh callback
    current_frame = 0;

    fun refresh_callback() {
      sprite.SetImage(frames[current_frame]);
      current_frame = (current_frame + 1) % frame_count;
    }

    Plymouth.SetRefreshFunction(refresh_callback);
    Plymouth.SetRefreshRate(${toString fps});

    // Set background color
    Window.SetBackgroundTopColor(1, 1, 1);
    Window.SetBackgroundBottomColor(1, 1, 1);
  '';
in
stdenv.mkDerivation rec {
  pname = "plymouth-gif-theme";
  description = "A plymouth theme that displays a custom GIF";
  version = "0.0.1";

  nativeBuildInputs = [
    envsubst
    ffmpeg
  ];

  phases = [
    "setupPhase"
    "convertPhase"
    "themePhase"
    "installPhase"
  ];

  setupPhase = ''
    mkdir "./theme"
    cd "./theme"
  '';

  convertPhase = ''
    mkdir -p "./frames"
    ffmpeg -i "${gif}" "./frames/frame-%d.png"
  '';

  themePhase = ''
    export frame_count=$(find "./frames" -type f | wc -l)
    envsubst < "${themeFile}" > "./plymouth-gif-theme.plymouth"
    envsubst < "${scriptFile}" > "./plymouth-gif-theme.script"
  '';

  installPhase = ''
    mkdir -p "$out/share/plymouth/themes/"
    cp -r "." "$out/share/plymouth/themes/plymouth-gif-theme"
  '';

  meta = {
    inherit description;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.toodeluna ];
  };
}
