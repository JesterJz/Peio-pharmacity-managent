import ReactDOM from 'react-dom';
import * as React from "react";
import { loadBlockchainData, loadWeb3 } from "./Web3helpers";

export default function SignUp() {

  const [accounts, setAccounts] = React.useState(null);
  const [auth, setAuth] = React.useState(null);

  const loadAccounts = async () => {
    let { auth, accounts, calero } = await loadBlockchainData();

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
