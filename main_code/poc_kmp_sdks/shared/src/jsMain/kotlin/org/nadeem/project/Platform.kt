package org.nadeem.project

actual fun getPlatform(): Platform = JsPlatform()

class JsPlatform : Platform {
    override val name: String = "JavaScript"
} 