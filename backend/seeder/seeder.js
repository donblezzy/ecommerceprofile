import mongoose from "mongoose";
import products from "./data.js";
import Product from "../models/product.js";


const seedProducts = async () => {
    try {
        // await mongoose.connect("mongodb://localhost:27017/shopIT")
        await mongoose.connect("mongodb+srv://donblezzy:Myschool12345@shopit.z1pjnwt.mongodb.net/ShopIT?retryWrites=true&w=majority&appName=ShopIT")

        await Product.deleteMany()
        console.log("Products are Deleted");

        await Product.insertMany(products)
        console.log("Products are added");

        process.exit()

    } catch (error) {
        console.log(error.message);
        process.exit()
    }
}

seedProducts();