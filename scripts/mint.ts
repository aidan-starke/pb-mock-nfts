interface TaskArgs {
	address: string;
	amount: number;
	tokenId: number;
	contract: "NFT" | "SFT";
}

const CONTRACTS = {
	NFT: "0x85225575aAE6e8275e3D2Be9e86268F916F3e2Be",
	SFT: "0xaEafb9c5EBfBaaFa6aE2cc4d487Eb6b302c4a51d",
};

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export default async function main(ethers: any, { address, amount, contract, tokenId }: TaskArgs) {
	const MockFactory = await ethers.getContractFactory(contract);
	const mock = MockFactory.attach(CONTRACTS[contract]);

	const isNft = contract === "NFT";

	console.log(`Minting ${amount} ${contract} to address: ${address}`);

	if (isNft) {
		for (let i = 1; i <= amount; i++) {
			console.log("Minting NFT:", i);
			const tx = await mock.mintTo(address);

			await tx.wait();
		}
	}

	if (!isNft) {
		const tx = await mock.mint(address, tokenId, amount);

		await tx.wait();
	}

	const balanceOf = isNft ? await mock.balanceOf(address) : await mock.balanceOf(address, tokenId);

	console.log("Balance:", balanceOf.toString());
}
