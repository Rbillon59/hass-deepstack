# Home Assistant Add-on: Hass-deepstack

## What is deepstack ?

DeepStack is an AI server that empowers every developer in the world to easily build state-of-the-art AI systems both on premise and in the cloud. The promises of Artificial Intelligence are huge but becoming a machine learning engineer is hard. DeepStack is device and language agnostic. You can run it on Windows, Mac OS, Linux, Raspberry PI and use it with any programming language.


## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "hass-deepstack" add-on and click it.
3. Click on the "INSTALL" button.

## How configure it

You can enable or disable authentication through api token by setting the `api_token` and setting the `auth`to true


### Addon Configuration

Add-on configuration:

```yaml
auth: true
api_key: superSecr3t
protocol: http
cert_file: cert.pem
key_file: key.pem
face_detection_enabled: true
object_detection_enabled: true
image_enhance_enabled: false
scene_detection_enabled: false
threadcount: 4
```

### Option: `auth` (required)

Enable or disable api endpoint authentication through token

### Option: `api_key` (required)

The api token needed to authenticate against the API

###  Option `face_detection_enabled` (required)

Think of a software that can identify known people by their names. Face Recognition does exactly that. Register a picture of a number of people and the system will be able to recognize them again anytime. Face Recognition is a two step process: The first is to register a known face and second is to recognize these faces in new pictures.

###  Option `object_detection_enabled` (required)

The object detection API locates and classifies 80 different kinds of objects in a single image.

To use this API, you need to enable the detection API when starting DeepStack

###  Option `image_enhance_enabled` (required)

The image enhance API enlarges your image by 4X the original width and height, while simulatenously increasing the quality of the image.

To use this API, you need to enable the Enhance API when starting DeepStack

###  Option `scene_detection_enabled` (required)


The scene recognition api classifies an image into one of 365 scenes.

To use this API, you need to enable the scene API when starting DeepStack.


###  Option `threadcount` (required)


By default, previous versions of DeepStack ran each endpoint on a single thread, this was changed to 5 threads in version 2022.01.1. To take full advantage of multiple cpu cores and threads, DeepStack allows you to specify the number of threads each endpoint will run with. This provides singificant performance boost, especially when running multiple requests often.


## How to use it ?

Once the addon is up and running you can access the deepstack API through your home assistant instance, like in : 

```yaml
image_processing:
  - platform: deepstack_object
    ip_address: <homeassistant-ip-address>
    port: 5000
    timeout: 20
    api_key: !secret deepstack_api_key
    save_file_folder: /config/snapshots/
    save_timestamped_file: True
    show_boxes: True
    targets:
      - target: person
        confidence: 80
    source:
      - entity_id: camera.entree
```

## Useful ressources :

### Documentation

https://docs.deepstack.cc/index.html#

## Support

Got questions?

You can open an issue on Github and i'll try to answer it

[repository]: https://github.com/Rbillon59/hass-deepstack

## License

This addon is published under the apache 2 license. Original author of the addon's bundled software is n8n