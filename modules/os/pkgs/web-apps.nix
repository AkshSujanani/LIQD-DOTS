{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		(makeDesktopItem {
			name = "chatgpt-web";
			desktopName = "ChatGPT";
			genericName = "AI Assistant";
			comment = "ChatGPT web app";
			exec = "${chromium}/bin/chromium --app=https://chatgpt.com";
			icon = "chromium";
			categories = [ "Network" "Utility" ];
			terminal = false;
		})
	];
}
