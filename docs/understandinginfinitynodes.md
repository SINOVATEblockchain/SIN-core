## *Understanding of the InfinityNode Technology*

  

**1.  What is an InfinityNode?**
    

Like other blockchain solutions, the main SINOVATE chain relies on hundreds of nodes spread across the globe, beyond all borders or proper jurisdiction.

In the SINOVATE network, each node hosts a replica of the main chain, allowing the ledger’s authenticity. In addition, infinitynodes help support the network by providing owners with additional custom-made, unique, and advanced functionality that typical network nodes cannot provide. In return, the blockchain delivers a reward to holders of InfinityNodes for each confirmation of transaction blocks alongside the Proof-of-Work and Proof-of-Stake consensus mechanisms. The InfinityNodes can be associated with the Proof-of-Service (PoSe) layer concept, initially created by the DASH project. As a Layer-1 solution, the SIN coin is the currency used in the committed contracts and reward payments delivered to one holder at every block generation.

**2.  Can InfinityNodes be considered as a masternode technology?**
   
No, SINOVATE uses a custom codebase written from scratch with unique concepts. There is no configuration file and requires burning the collateral to establish a contract with the Proof-of-Service layer of the network (see (4)). This is the Proof-of-Burn mechanism. The future owner commits the contract with a specific and unique command for 12 months (only sending coins to the unspendable address will lead to losing your SIN coins). This contract can have a different number of SIN coins depending on the selected Tier. Hence, the InfinityNode will receive rewards from generated blocks according to the payment round. It will enable us to retrieve the burnt collateral with additional income. This payment round is fully deterministic (see (5)) and depends on the number of active InfinityNodes in the Tier. It means the frequency of received rewards may vary over time which is very different from the masternodes system where the frequency is mainly decreasing. After 12 months, the InfinityNode expires and the owner should have collected the burnt collateral and additional incomes with all the received block rewards. The collateral is not returned at the end of the contract.

  

**3.  What are the different options called Tiers of InfinityNodes?**  
      
    

InfinityNode owners have three different levels to establish their nodes called Tiers. Each Tier is seen as a layer of the network. They provide separate and distinctive functions to ensure decentralization, overall network stability, and Data Storage service, which is the major strength of SINOVATE. Each level requires a different number of coins to create a node which is defined for the following:

-   MINI Tier: 100 000 SIN coins,
    
-   MID Tier: 500 000 SIN coins,
    
-   BIG Tier: 1 000 000 SIN coins.
    

As a reminder, the SIN coins used for starting the “InfinityNodes” must be transferred to an unusable SIN wallet address as the Proof-of-Burn mechanism.

  

**4.  What is the Proof-of-Burn (PoB) mechanism in SINOVATE?**
    

The coin destruction mechanism known as Proof-of-Burn (PoB), supports a self-regulating circulating suppy based on the offer and demand of SIN coin market. This regulation is made by transferring transaction fees to an unusable SIN address. They are then burnt, which is one of the main functions of the PoB mechanism. Furthermore, as the ledger is public and open to everyone, the unusable generic address of the project below makes it possible to trace all transactions and actions linked to the PoB mechanism:

  

**SinBurnAddress123456789SuqaXbx3AMC**

  

One of the characteristics specific to SINOVATE is to have extended this principle to create PoSe nodes of the blockchain called InfinityNodes. This implies that all the SIN coins pledged (“collateral”) to rule on the veracity of their posting are transferred immutable and recorded as unusable. This process helps increase the decentralized network's validity. Furthermore, it ensures that all participating nodes reach consensus or risk losing transaction block rewards to fill back the collateral.

This requirement for stability ensures the endurance of the network. In addition, it limits the circulating supply of SIN coins, thus reducing selling pressure on the exchanges. As a reminder, this is not the case with traditional Masternodes, which can be liquidated and sold at any time.

The PoB mechanism offers this desired stability because of future use cases of the Data Storage functions, whose cloud data is stored in a decentralized manner hosted on the InfinityNodes.

  

**5.  What does “Deterministic” InfinityNodes mean?**
    

The word “deterministic” means every InfinityNode receives a reward from generated blocks in an order specified by the round payment list (called Statement). Hence, the network guarantees a regular payment for InfinityNodes and removes any current luck in non-deterministic masternode systems. It enables easy tracking and assessment of the return on investment for the owner.

**6.  What are the purpose and the different functions of InfinityNodes in the network?**
    

  

Proof-of-Burn not only self-regulates the circulating supply, but this mechanism also brings another significant benefit in the decentralized system: A 100% runtime. Hence, if the owner wants to recover the coins used in the committed contract, He must guarantee that his InfinityNode is always connected with suitable hardware and Internet connection. Technically, it requires to engage money to prove their good intentions by committing the contract (RPC Command: Infinitynodeburnfund) and to engage the hardware (VPS as a data hoster/ RPC Command: Infinitynodeupdatemetadata)

This stability enables our network to transfer and store data in InfinityNodes in a low-cost and high-speed manner. It is the foundation of SINOVATE Nephele: The Incorruptible Data Storage. Nephele is the decentralized Cloud Infrastructure where any web 3.0 application will plug for their own data management. The data storage for MINI, MID, and BIG should have the same priority level by default for storing data. The offers and demands would regulate specifically the data market in SINOVATE. For instance, BIG is a higher investment risk than MINI because the collateral is burnt. Therefore, BIG InfinityNodes owners must propose reliable and efficient data storage to optimize their incomes with block rewards. Then, BIG hosters would probably have more crucial data and collect more data. The SIN price growth will reward the node owners.

BIG Tier also contributes to the Layer-1 security as a critical layer for validating the reward payment from the block (see (7)). Finally, it could be a fundamental Tier in the InfiniteChain. The BIG InfinityNode could be a Layer-2 validator of side chains. They can operate alongside the mainchain. In addition, they will have the possibility to interact with SINOVATE Nephele for storing their data.

  
  
  

**7.  What is the LockReward mechanism?**
    

Using novel cryptographic systems (such as Schnorr MuSig, a Schnorr-based signature aggregation scheme: [https://en.wikipedia.org/wiki/Schnorr_signature](https://en.wikipedia.org/wiki/Schnorr_signature)), the LockReward mechanism collects signatures from network participants. It uses them as novel proof for security purposes. The participants must be specially selected to meet this new security standard, where SINOVATE InfinityNodes come into play.

InfinityNodes are "burn to run" collateralized nodes that are rewarded over time based on their LockReward commitments. (the 12-month contract commitment which is based on the transaction to the unspendable address with a specific command) Each node must be online and listening to contribute their commitment. Each node validates the reward which is being produced by the block generation. LockReward essentially serves as a powerful security tool, benefiting the node owners and the ledger itself.

In the SINOVATE mainchain, BIG Tier operates as a critical layer for validating the reward payment from block validations. Therefore, 16 BIG InfinityNodes called network participants will participate in certifying the healthiness of the InfinityNode of each Tier in every block that should receive a reward for its contribution to the Proof-of-Services layer composed of data storage or instant payments. This novel cryptographic mechanism is called LockReward, based on the MuSig, a Schnorr-based signature aggregation scheme. The InfinityNode receiver must then collect signatures from network participants and validate its aggregation to certify its validity.

  

When the InfinityNode is a candidate to receive the block reward, the LockReward mechanism works as follows:

1.  The candidate collects the blockhash of the N-100 blockheight where N is the current blockheight. The gap of 100 has been selected to not be disturbed by the security protocols against 51% attacks with the blockchain reorganization,
    
2.  The candidate gathers all the InfinityNode IDs from the BIG Tier,
    
3.  With every InfinityNode ID fused with the blockhash, the InfinityNode calculates a new Hash. This creates a list of Hash codes,
    
4.  The InfinityNode sorts all the newly created Hash in an ascending or descending order. This is performed by Hash comparisons which is equivalent to comparing numbers,
    
5.  16 BIG InfinityNodes are then selected by considering the 16 first Hash created by the candidate,
    
6.  The candidate selects 4 of the 16 BIG InfinityNodes to build a Schnorr MuSig with the selected BIG InfinityNodes. The 4 BIG InfinityNodes are the first to answer the candidate request for the Schnorr MuSig. In other words, the 4 BIG InfinityNodes have the lowest latency with the candidate.
    
7.  The candidate commits to the network (on-chain) the Schnorr MuSig. The candidate receives its reward if it is accomplished in 1 minute (mean of block generation interval).
    

The first significant benefit of LockReward is that a group of BIG InfinityNodes does the Schnorr MuSig. Therefore, it considerably reduces the risk of falsification because the attacker must have the four malicious BIG InfinityNodes picked by the algorithm. The second significant benefit is the healthiness of the InfinityNode that must have perfect hardware and Internet connection which is mandatory for a scalable, fast, and reliable decentralized Cloud. For instance, the user will communicate directly with InfinityNode to upload and download its data. Hence, there is no need to split the data from the user, which saves considerably a lot of time. The section about SINOVATE Nephele: The Incorruptible Data Storage highlights how it is working more precisely.

  
  

**8.  Which payments and rewards does an InfinityNode receive?**
    

  

An InfinityNode is a peer which executes operations for the Proof-of-Services (PoSe) layer, such as instant transactions or governance votes. The owner receives a reward from generated blocks for this contribution. Then, the running cost of an InfinityNode is mainly covered by the block reward, and an owner can already satisfy a return on investment (ROI) from this. The Proof-of-Burn mechanism is applied to the transaction, votes, and data transaction fees plus the collateral of InfinityNodes to execute a 12-month contract commitment. During the contract period, InfinityNode participates in the SINOVATE decentralized Cloud storage. The owner can then receive an additional income for data storage depending on the contract payment encapsulation in the data transaction fees.

  

**9.  What happens when the Infinity Node expires?**
    

  

The contract of InfinityNodes expires 12 months after the Proof-of-Burn-based commitment. The InfinityNode is then rejected from the deterministic list of the payment round for the PoSe layer. The InfinityNode will be disconnected from the network and not receive more rewards from blocks. The owner would not be able to participate in the governance vote. The data storage is deactivated, and the owner does not receive more data. This does not impact the user experience because the data are replicated over multiple InfinityNodes by default.

The DAO is investigating possible solutions to continue participating in the data storage if you submit at least one contract. This is not in the current development roadmap, but users will be informed if this idea becomes a reality. However, the running cost will not be covered by block rewards, and it is up to the owner to pursue or not the activity.

  
  

**10.  What are the risks for an investor/InfinityNode owner?**
    

  

Before investing in an InfinityNode, the owner (or the investor) must understand that it is fundamental to guarantee the InfinityNode has a maximized runtime that means it is permanently connected to the SINOVATE blockchain network. A disconnection or a handover of the InfinityNode will result in missing rewards, reducing the chance to recover the committed contract properly.

A second risk is the hardware quality (VPS) of the InfinityNode. We highly recommend setting up an InfinityNode in a unique and dedicated VPS. Avoiding complex setups with multiple PoSe solutions will maximize the chance of successful LockReward execution.
