# Godot Websocket Server
---
This is a skeleton for a websocket server made in Godot.

## How to host the server

The server comes as a Godot project, so you can either run it in Godot engine or export the solution as an executable file and run it using the [--headless](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_dedicated_servers.html) option or export it as dedicated server to strip all the visuals from the server.

Don't forget to open the port used in your hosting solution.
The port number can be defined in `ServerSettings.tres`

## How to connect the client

Find instructions on the Client on my separate [Godot Websocket Client](https://github.com/ZhengYiHu/Godot-Websocket-Client) repository.

## SLL Certification

The server will work normally if all the clients connecting are not web builds that require secured HTTPS connections, otherwise the connection where this server is hosted will need a [SLL Certificate](https://www.cloudflare.com/en-gb/learning/ssl/what-is-an-ssl-certificate/) that can be set up using one of many providers, for example [Let's Encrypt](https://letsencrypt.org/).

You can now place your certificate and key under `res://Certificate` and reference them in the `ServerSettings.tres` properties 

![](https://private-user-images.githubusercontent.com/33153763/279197488-bd0323d7-71bb-4e46-8be6-1f3e7a6b36b9.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE2OTg3MDEwMjgsIm5iZiI6MTY5ODcwMDcyOCwicGF0aCI6Ii8zMzE1Mzc2My8yNzkxOTc0ODgtYmQwMzIzZDctNzFiYi00ZTQ2LThiZTYtMWYzZTdhNmIzNmI5LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEwMzAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMDMwVDIxMTg0OFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBmMmYzNWU1MGM3ZWE5M2M1YTVlNzE0ODE5Zjg4N2MxYWJjYzRiMDhjMWY1NzVjMDc3NGQ5MzE0YTE3ZGI0YzYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.6xvw2aNwexcd_v72KOYxdN5rGD1YjQlHVg03Wu1C8aw)

The `Dev` can be set to `true` to bypass any certificate check while testing the server on dev environments.

## Features

- Essential Synchronization RPCs
-  Players movement Synchronization Interpolation
-  Packets encoding and decoding.

## Shared code

Godot doesn't have a good solution to handle shared codebase between Server and Client that don't belong in the same project.
What this project does is to simply copy over the `res://DataBuses` folder in the client project, that contains all data structures used while communicating with the client.

## Why websocket over UDP

The main goal of this project was to create an accessible server for web based multiplayer games and since [browser games cannot utilize UPD networks](https://gafferongames.com/post/why_cant_i_send_udp_packets_from_a_browser/), I used a websocket connection for all the packet transfers.

## Demo

You can find a game using this very setup on my game [Duck Hub](https://zyhu.itch.io/duckhub) in itch.io.