import ReactDOM from 'react-dom';
import * as React from "react";
import { loadBlockchainData, loadWeb3 } from "./Web3helpers";

export default function Order() {
    const [accounts, setAccounts] = React.useState(null);
    const [calero, setCalero] = React.useState(null);
    const loadAccounts = async () => {
        let { auth, accounts, calero } = await loadBlockchainData();
        setAccounts(accounts);
        setCalero(calero);
    };

    const order = async () => {
        var user_id = sessionStorage.getItem('user_id');
        var order_id = sessionStorage.getItem('order_id');
        var total_price= sessionStorage.getItem('total_price_orders');
        var dateTime = sessionStorage.getItem('created_at');
        // var data = JSON.parse(sessionStorage.orders);
        try {
            await calero.methods
                .addInvoice(accounts,
                user_id,
                order_id,
                total_price,
                "msg",
                dateTime).send({ from: accounts });
        window.location.href = "http://127.0.0.1:8001/admin/sales";
        } catch (e) {
            console.log(e.message);
        }
    };

    React.useEffect(() => {
        loadWeb3();
    }, []);

    React.useEffect(() => {
        loadAccounts();
    }, []);
    return (
        // <button class="btn btn-primary btn-block" >Order</button>
        <button 
        className='btn btn-primary submitFormCreate'
        onClick={order}>
          Order
        </button>
    );
}

if (document.getElementById('btnSubmit')) {
  ReactDOM.render(<Order/>,document.querySelector('#btnSubmit'));
}
