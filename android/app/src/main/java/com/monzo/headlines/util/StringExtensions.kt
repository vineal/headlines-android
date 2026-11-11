package com.monzo.headlines.util

private val TAG_REGEX = Regex("<[^>]+>")
private val PARAGRAPH_BREAK_REGEX = Regex("</p>\\s*<p>")
private val URL_REGEX = Regex("""https?://\S+?(?=["'\s>]|$)""")

/** Strips HTML tags from Guardian body copy, mirroring the iOS `strippingTags` extension. */
fun String.strippingTags(): String {
    val withParagraphBreaks = PARAGRAPH_BREAK_REGEX.replace(this, "\n\n")
    return TAG_REGEX.replace(withParagraphBreaks, "")
}

/** Finds the first URL-looking substring, mirroring the iOS `NSDataDetector`-based `url` extension. */
fun String.firstUrl(): String? = URL_REGEX.find(this)?.value
