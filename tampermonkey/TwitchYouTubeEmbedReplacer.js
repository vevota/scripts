// ==UserScript==
// @name         Twitch YouTube Embed Replacer (Under Controls)
// @namespace    http://tampermonkey.net/
// @version      1.2
// @description  Replace Twitch player with YouTube stream only when you click the button
// @match        https://www.twitch.tv/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    function addButton() {
        if (document.getElementById('yt-replace-btn')) return;

        // Find the container under the player controls
        const controlsBar = document.querySelector('.player-controls__left-control-group')?.parentElement;
        if (!controlsBar) return;

        const btn = document.createElement('button');
        btn.id = 'yt-replace-btn';
        btn.textContent = 'Replace with YouTube';
        btn.style.cssText = `
            background-color: #18181b;
            color: #efeff1;
            border: 1px solid #3a3a3d;
            padding: 5px 12px;
            margin-left: 8px;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
        `;
        btn.onmouseenter = () => btn.style.backgroundColor = '#26262c';
        btn.onmouseleave = () => btn.style.backgroundColor = '#18181b';

        btn.onclick = () => {
            const ytUrl = prompt('Enter YouTube Live URL:');
            if (!ytUrl) return;

            const match = ytUrl.match(/(?:v=|youtu\.be\/)([a-zA-Z0-9_-]{11})/);
            if (!match) {
                alert('Invalid YouTube URL');
                return;
            }
            const videoId = match[1];
            const embedUrl = `https://www.youtube.com/embed/${videoId}?autoplay=1`;

            // Mute Twitch before replacing
            document.querySelector('video')?.pause();

            const playerContainer = document.querySelector('.video-player__container');
            if (playerContainer) {
                playerContainer.innerHTML = `
                    <iframe width="100%" height="100%"
                        src="${embedUrl}"
                        frameborder="0"
                        allow="autoplay; encrypted-media"
                        allowfullscreen>
                    </iframe>
                `;
            }
        };

        controlsBar.appendChild(btn);
    }

    const observer = new MutationObserver(addButton);
    observer.observe(document.body, { childList: true, subtree: true });
})();
