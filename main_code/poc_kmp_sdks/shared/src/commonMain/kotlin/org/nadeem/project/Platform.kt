package org.nadeem.project

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform