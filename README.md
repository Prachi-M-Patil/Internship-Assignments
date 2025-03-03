const express = require("express");
const EventEmitter = require("events");

const app = express();

app.use(express.json());

const orders = {};
const orderEmitter = new EventEmitter();

app.post("/order", (req, res) => {
    const { orderId, foodItem, customerName } = req.body;

    if (!orderId || !foodItem || !customerName) {
        return res.status(400).json({ error: "Missing order details" });
    }

    // Store the order with "processing" status
    orders[orderId] = { orderId, foodItem, customerName, status: "Processing" };

    console.log(`Order received: ${orderId}`);

    res.json({ message: "Order received and is being processed", orderId });

    processOrder(orderId);
});

async function processOrder(orderId) {
    await new Promise((resolve) => setTimeout(resolve, 30000)); // Simulate 5 sec delay

    if (orders[orderId]) {
        orders[orderId].status = "Ready";
        orderEmitter.emit("orderReady", orderId);
    }
}

orderEmitter.on("orderReady", (orderId) => {
    console.log(`Order Ready: ${orderId}`);
});

app.get("/order/:id", (req, res) => {
    const orderId = req.params.id;
    const order = orders[orderId];

    if (!order) {
        return res.status(404).json({ error: "Order not found" });
    }

    res.json({ orderId, status: order.status });
});

app.listen(3000, () => {
    console.log(`Server running on http://localhost:${3000}`);
});
