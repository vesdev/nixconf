{ ... }:
let
  imageViewer = "feh.desktop";
  browser = "librewolf.desktop";
  textEditor = "helix.desktop";
in
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = imageViewer;
        "image/jpeg" = imageViewer;
        "image/bmp" = imageViewer;
        "image/gif" = imageViewer;
        "image/svg+xml" = imageViewer;
        "image/webp" = imageViewer;

        "text/html" = browser;
        "text/xml" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "text/english" = textEditor;
        "text/plain" = textEditor;
        "application/pdf" = "zathura.desktop";
      };
    };

    desktopEntries = {

      helix = {
        name = "Helix";
        genericName = "Text Editor";
        exec = "hx %F";
        terminal = true;
        icon = "helix";
        startupNotify = false;
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };

      feh = {
        name = "Feh";
        genericName = "Image Viewer";
        exec = "feh %F";
        terminal = false;
        icon = "feh";
        startupNotify = false;
        categories = [
          "Utility"
          "VectorGraphics"
          "RasterGraphics"
        ];
        mimeType = [
          "image/png"
          "image/jpeg"
          "image/bmp"
          "image/gif"
          "image/svg+xml"
          "image/webp"
        ];
      };

      zathura = {
        name = "Zathura";
        genericName = "Document Viewer";
        exec = "zathura %F";
        terminal = false;
        icon = "zathura";
        startupNotify = false;
        categories = [
          "Utility"
          "VectorGraphics"
          "RasterGraphics"
        ];
        mimeType = [ "application/pdf" ];
      };

      virt-manager = {
        name = "Virt Manager";
        exec = "env GDK_BACKEND=x11 virt-manager";
        terminal = false;
        icon = "virt-manager";
        startupNotify = false;
      };
    };
  };
}
