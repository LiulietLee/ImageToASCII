# ImageToASCII
A model about transforming an image to ASCII characters written by Swift.

![](https://cloud.githubusercontent.com/assets/9763162/16355549/2a4a717e-3aec-11e6-8057-ffd03f86a08b.jpg)
![](https://cloud.githubusercontent.com/assets/9763162/16355556/70f8cdf0-3aec-11e6-91a8-a088dca788b9.jpg)

## Install
Just move the "Source/LLTransformer.swift" to your project.

## Usage
You can download this project to see the simple example.

```
let transformer = LLTransformer()
let yourImage = UIImage(named: "your_image_title.png")
let text = transformer.convertUIImageToText(image: yourImage, clarity: 98)
label.text = text     // or some other cool things
```

The **convertUIImageToText(image: UIImage, clarity: Int) -> String** function return a string and it has two arguements:
- image: The UIImage which will be converted.
- clarity: It's greater than 0 and smaller than 100. The greater the argurment, the clearer the string picture.
