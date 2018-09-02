# MistServer

MistServer is a streaming media server that works well in any streaming environment even on a Raspberry Pi! It bridges the gap between dedicated media servers and web servers, performing the best of both worlds when it comes to media streaming delivery.

The opensource version works best with HLS live streaming (gaming) with programs such as Open Broadcaster Software (OBS) or Xsplit! If you want more options such as VOD, buy a pro-license.

**What makes this docker build better as the official one from DDTECH/MistServer?**   
It's more secure and because on `docker stop` it will gracefully shutdown your processes. It prevents data corruption and all config-files will be saved before shutting down.

Usage 
-----------
```
docker create --name=mistserver \   
-v /etc/localtime:/etc/localtime:ro \   
-v <path to config>:/config \   
-v <path to video>:/media \   
-p 4242:4242 -p 1935:1935 \   
-p 554:554 -p 8080:8080 \   
r0gger/mistserver   
```   
**or use:**   
   
```
docker create --name=mistserver \   
-v /etc/localtime:/etc/localtime:ro \   
-v <path to config>:/config \   
-v <path to video>:/media \   
--net=host \   
r0gger/mistserver   
```   
    

**Parameters**    
`-p 4242` - Web UI  
`-p 1935` - RTMP  
`-p 554` - RTSP   
`-p 8181` - HTTP / HLS   
`-v /etc/localhost:ro` - for timesync (read-only) - *optional*   
`-v /config` - config and log files  
`-v /media` - video and audio files 

Build & run Free version
-----------
1. Build: `docker build -t mistserver .`   
2. Run container:    
`docker run -i -t -p 1935:1935 -p 4242:4242 -p 554:554 -p 8080:8080 -v /my-folder:/config -v /my-folder/video:/media /etc/localtime:/etc/localtime:ro --name mistserver mistserver:latest /sbin/my_init`   
3. Login to http://mydomain.tld:4242 and enter a username/password.   
4. Click on "Enable protocols".
5. Enter a "Human readable name" and set a thick to "Force JSON file save".   

Build Pro version
-----------
1. `git clone https://github.com/trydock/mistserver mistserver-pro`
2. `nano Dockerfile`
3. `ENV MISTSERVER=http://url-to-pro-version`.
4. `docker build -t mistserver-pro .`

Setup live streaming with RTMP
-----------
1. Go to **Streams** and click **New stream**.   
2. Stream name: obs 
3. Source: `push://` or `push://your-ip-address`   
4. Now go to Open Broadcaster Software and enter to **FMS URL:** `rtmp://mydomain.tld:1935/live/` and **Play Path:** `obs`.   

Embed within website
-----------
```
<video id=autoplay width="720" height="360" class="video-js vjs-default-skin vjs-big-play-centered" controls>
  <source src="http://mydomain.tld:8080/hls/stream_name.m3u8" type="application/x-mpegURL">
</video>
<link href="https://vjs.zencdn.net/6.2.8/video-js.css" rel="stylesheet">
<script src="https://vjs.zencdn.net/6.2.8/video.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/videojs-contrib-hls/5.12.1/videojs-contrib-hls.min.js"></script>
<script>
var player = videojs('autoplay');
player.play();
</script>
```
Links
-----------
Website: http://mistserver.org   
Github: https://github.com/DDVTECH/mistserver   
Video.js HLS plugin: https://github.com/videojs/videojs-contrib-hls/releases


