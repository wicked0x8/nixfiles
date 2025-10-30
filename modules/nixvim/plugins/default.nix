{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      barbecue.enable = true;

      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true;
            long_message_to_split = true;
          };
          routes = [
            {
              view = "notify";
              filter = {
                event = "msg_showmode";
              };
            }
            {
              view = "cmdline_output";
              filter = {
                event = "msg_show";
                min_height = 15;
              };
            }
          ];
        };
      };

      lualine = {
        enable = true;
        settings = {
          options.theme = "nord";
          sections = {
            lualine_c = [ "filename" ];
          };
        };
      };

    };
  };
}
