
const express = require("express");
const EventEmitter = require("events");

const app = express();
const PORT = 3000;

// Middleware to parse JSON
app.use(express.json());

// Order storage
const orders = new Map();
const orderEmitter = new EventEmitter();

// Accept New Order (POST /order)
app.post("/order", (req, res) => {
    const { orderId, foodItem, customerName } = req.body;

    if (!orderId || !foodItem || !customerName) {
        return res.status(400).json({ error: "Missing order details" });
    }

    // Store the order with "processing" status
    orders.set(orderId, { orderId, foodItem, customerName, status: "Processing" });

    console.log(`Order received: ${orderId}`);

    // Simulate async order processing using Promise
    processOrder(orderId);

    res.json({ message: "Order received and is being processed", orderId });
});

// Process Order Asynchronously
async function processOrder(orderId) {
    await new Promise((resolve) => setTimeout(resolve, 5000)); // Simulate 5 sec delay

    if (orders.has(orderId)) {
        orders.get(orderId).status = "Ready";
        orderEmitter.emit("orderReady", orderId);
    }
}

// Emit event when order is ready
orderEmitter.on("orderReady", (orderId) => {
    console.log(`Order Ready: ${orderId}`);
});

// Retrieve Order Status (GET /order/:id)
app.get("/order/:id", (req, res) => {
    const orderId = req.params.id;
    const order = orders.get(orderId);

    if (!order) {
        return res.status(404).json({ error: "Order not found" });
    }

    res.json({ orderId, status: order.status });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
