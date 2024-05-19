pragma solidity ^0.8.0;

contract PayPerView {
    // コントラクトのオーナーのアドレス
    address public owner;0x...

    // イベントの定義
    event PaidForViewing(address indexed _from, uint256 _value);

    // コンストラクター
    constructor() {
        owner = msg.sender;
    }

    // ビューを支払う関数
    function payForViewing() public payable {
        // 送金された金額が正しいか確認
        require(msg.value > 0, "You need to send some Ether");

        // オーナーに送金
        payable(owner).transfer(msg.value);

        // イベントを発火
        emit PaidForViewing(msg.sender, msg.value);
    }

    // コントラクトの破棄関数
    function destroy() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(payable(owner));
    }
}
