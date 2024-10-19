# 🚀 Lost and Found Registry - Frontend

Welcome to the **Lost and Found Registry** frontend, a decentralized application built on the **Aptos Blockchain**. This platform enables users to register lost items, submit reports for found items, and manage claims transparently. All interactions and reward transfers are securely handled through smart contracts deployed on the Aptos blockchain.

---

## 🔗 Links

- **Live Demo**: [Lost and Found Registry](https://aptos-lost-found-registry.vercel.app/)
- **Smart Contract Explorer**: [Aptos Explorer](https://explorer.aptoslabs.com/account/0x7792db2bc2e3c11f4485060e1112fab7a9d88d971af5cc638a9a486d6fb7ca61/modules/code/LostAndFoundRegistry?network=testnet)

---

## ✨ Key Features

- **Register Lost Items**: Users can register lost items with descriptions and offer rewards to finders.
- **Submit Found Items**: Finders can submit reports with descriptions for the owner's verification.
- **Verify Finder & Transfer Rewards**: Owners can verify found items and reward finders automatically using APT.
- **View Lost Items**: Users can browse all registered lost items publicly.
- **Track Found Submissions**: Owners can view submissions for specific lost items and manage claims.

---

## 📋 Prerequisites

Ensure you have the following installed:

- **Node.js** (v16 or higher)
- **npm** or **yarn**
- **Aptos Wallet** (e.g., **Petra Wallet**) for blockchain interactions

---

## ⚙️ Setup Instructions

### 1. Move to Folder

```bash
cd lost-and-found-registry
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Environment Variables

Create a `.env` file in the project root and add the following variables:

```bash
PROJECT_NAME=LostAndFoundRegistry
VITE_APP_NETWORK=testnet
VITE_MODULE_ADDRESS=0x7792db2bc2e3c11f4485060e1112fab7a9d88d971af5cc638a9a486d6fb7ca61
```

Replace `<VITE_MODULE_ADDRESS>` with the actual address of your deployed smart contract.

### 4. Run the Development Server

```bash
npm run dev
```

The app will be available at `http://localhost:5173`.

### 5. Deploy the Smart Contract

To deploy the smart contract:

1. **Install Aptos CLI**.
2. **Update the Move.toml file** with your wallet address:

   ```bash
   sys_addrx = "0xca10b0176c34f9a8315589ff977645e04497814e9753d21f7d7e7c3d83aa7b57"
   ```

3. **Set the module address for deployment**:

   ```bash
   my_addrx = "7792db2bc2e3c11f4485060e1112fab7a9d88d971af5cc638a9a486d6fb7ca61"
   ```

4. **Create a new Aptos account**:

   ```bash
   aptos init
   ```

5. **Compile and publish the contract**:

   ```bash
   aptos move compile
   aptos move publish
   ```

---

## 🛠 How to Use the Platform

### 1. Connect Wallet

Connect your **Aptos wallet** (e.g., Petra Wallet) to interact with the platform. This enables you to register lost items, submit found item reports, and verify claims.

### 2. Register a Lost Item

1. Navigate to the **Register Lost Item** section.
2. Provide the item’s title, description, and reward amount in APT.
3. Submit the form to register the lost item on the blockchain.

### 3. Submit a Found Item

1. Go to the **Submit Found Item** page.
2. Select the lost item from the list and describe the found item.
3. Submit the report, notifying the owner of the found item.

### 4. Verify Finder & Transfer Reward

As the owner:

1. Navigate to the **My Items** section.
2. Review submissions for your lost items.
3. Verify the finder’s submission and approve the reward transfer.
4. The finder will automatically receive the reward in APT.

### 5. View Lost and Found Items

1. Browse all registered lost items in the **View Lost Items** section.
2. View submission reports for specific items in the **Found Submissions** section.

---

## 📊 Scripts

- **`npm run dev`**: Start the development server.
- **`npm run build`**: Build the project for production.
- **`npm test`**: Run unit tests.

---

## 🔍 Dependencies

- **React**: Library for building UIs.
- **TypeScript**: Typed JavaScript for better development.
- **Aptos SDK**: JavaScript SDK to interact with the Aptos blockchain.
- **Ant Design / Tailwind CSS**: For modern UI design and responsive layouts.
- **Petra Wallet Adapter**: To connect and interact with Aptos wallets.

---

## 📚 Available View Functions

- **View All Lost Items**: Displays all lost items registered on the platform.
- **View Lost Items by Owner**: Lists lost items registered by a specific owner.
- **View Submissions for Lost Items**: Shows submissions made for a specific lost item.

---

## 🛡 Security and Transparency

- **Smart Contracts** handle all reward transfers and submissions on-chain, ensuring transparency.
- **No Intermediaries**: Rewards are transferred directly from the owner to the finder.
- **Tracking Claims**: Users can track the status of their lost items in real-time.

---

## 🌐 Common Issues and Solutions

1. **Wallet Connection Errors**: Ensure the Aptos wallet extension (e.g., Petra) is installed and active.
2. **RPC Rate Limits**: Use **third-party RPC providers** like **QuickNode** or **Alchemy** to avoid rate limits.
3. **Transaction Failures**: Verify that your wallet has enough balance and correct permissions.

---

## 🚀 Scaling and Deployment

If deploying to **Vercel**, consider the following solutions:

- Use **private RPC nodes** to handle blockchain interactions reliably.
- Implement **throttling** to prevent RPC request overload.
- Leverage **WebSockets** for real-time status updates.

---

## 🎉 Conclusion

The **Lost and Found Registry** offers a decentralized platform to manage lost items, found submissions, and reward distribution seamlessly. With secure smart contracts and transparent operations, users can efficiently handle lost-and-found claims, ensuring items are returned and rewards are fairly distributed.
