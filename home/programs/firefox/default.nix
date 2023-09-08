{ config, pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                id = 0;
                search.force = true;
                settings = {
                    "app.update.enabled" = false;
                    "toolkit.telemetry.prompted" = "2";
                    "toolkit.telemetry.rejected" = true;
                    "browser.download.autohideButton" = false;
                    "browser.download.panel.shown" = true;
                    "browser.shell.checkDefaultBrowser" = false;
                    "browser.toolbars.bookmarks.visibility" = "always";
                    "browser.startup.homepage" = "https://www.google.fr";
                    "browser.search.region" = "FR";
                    "browser.search.isUS" = false;
                    "browser.formfill.enable" = false;
                    "privacy.clearOnShutdown.cookies" = false;
                    "privacy.sanitize.sanitizeOnShutdown" = true;
                    "network.cookie.thirdparty.sessionOnly" = true;
                };
            };
        };
    };
}