  pragma solidity 0.8.10;

  import "aave-v3-core/flashloan/base/FlashLoanSimpleReceiverBase.sol";

  contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {}

    function flashLoan(address _token, uint256 _amount) public {
      address receiverAddress = address(this); 
      address asset = _token;
      uint256 amount = _amount; 
      bytes memory params = "";
      uint16 referralCode = 0;

      POOL.flashLoanSimple(receiverAddress, asset, amount, params, referralCode);
    }

    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params) external override returns (bool) {
      uint256 totalAmount = amount + premium; 
      IERC20(asset).approve(address(POOL), totalAmount);
      return true;
    }
  }
