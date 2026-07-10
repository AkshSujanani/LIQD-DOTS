-- Rules for chromium-browser
-- opacity = "active inactive floating"
hl.window_rule({
	match = { class = "chromium-browser" },
	opacity = "1.0 override 0.95 override",
	workspace =  "3 silent",
})
