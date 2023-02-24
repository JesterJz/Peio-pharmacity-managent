import ReactDOM from 'react-dom';
import * as React from "react";
import { loadBlockchainData, loadWeb3 } from "./Web3helpers";

// import { useNavigate } from "react-router-dom";
export default function SignUp() {

  const [accounts, setAccounts] = React.useState(null);
  const [auth, setAuth] = React.useState(null);

  const loadAccounts = async () => {
    let { auth, accounts, calero } = await loadBlockchainData();
    console.log(123);

    // const test = await calero.methods.viewInvoice(13).call();
    // console.log(test,123);
        // try {
        //   await calero.methods
        //     .addInvoice('0x97d0D2e623c9AcBBbf9a8b17dbF9E19D642F6093',
        //       123,
        //       "Asd").send({ from: accounts });
    
        // } catch (e) {
        //   console.log(e.message);
        // }
    setAccounts(accounts);
    setAuth(auth);
  };

  React.useEffect(() => {
    loadWeb3();
  }, []);

  React.useEffect(() => {
    loadAccounts();
  }, []);
  return (
	  <input name="account_id" value={accounts} hidden/>
  );
}

if (document.getElementById('accountId')) {
  ReactDOM.render(<SignUp/>,document.querySelector('#accountId'));
}
