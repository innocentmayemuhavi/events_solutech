import {
  createContext,
  useEffect,
  useState,
  type Dispatch,
  type SetStateAction,
} from "react";
import type { Account, Transaction } from "../types/treasury";
import { INITIAL_ACCOUNTS } from "../constants";

const AppContext = createContext<{
  accounts: Account[];
  setAccounts: Dispatch<SetStateAction<Account[]>>;
  transactions: Transaction[];
  setTransactions: Dispatch<SetStateAction<Transaction[]>>;
  modal: null | React.ReactNode;
  setModal: Dispatch<SetStateAction<null | React.ReactNode>>;
  showModal: boolean;
  setShowModal: Dispatch<SetStateAction<boolean>>;
}>({
  accounts: [],
  setAccounts: () => {},
  transactions: [],
  setTransactions: () => {},
  modal: null,
  setModal: () => {},
  showModal: false,
  setShowModal: () => {},
});

const AppProvider = ({ children }: { children: React.ReactNode }) => {
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [modal, setModal] = useState<null | React.ReactNode>(null);
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      setAccounts(INITIAL_ACCOUNTS);
      setTransactions([]);
    };
    fetchData();
  }, []);

  return (
    <AppContext.Provider
      value={{
        accounts,
        setAccounts,
        transactions,
        setTransactions,
        modal,
        setModal,
        showModal,
        setShowModal,
      }}
    >
      {children}
    </AppContext.Provider>
  );
};

export { AppContext, AppProvider };
