import { useContext, useState, useMemo, useEffect } from "react";
import Layout from "../../components/layout";
import TransactionLog from "../../components/tables/transactions";
import { AppContext } from "../../context";
import type { Currency } from "../../types/treasury";

const TransferLogsPage = () => {
  const { transactions, accounts } = useContext(AppContext);
  useEffect(() => {
    document.title = "Transfer Logs - Niobi Treasury";
  }, []);
  // Filter state
  const [filterAccount, setFilterAccount] = useState<string>("");
  const [filterCurrency, setFilterCurrency] = useState<Currency | "">("");

  // Filter transactions based on selected filters
  const filteredTransactions = useMemo(() => {
    return transactions.filter((transaction) => {
      // Filter by account
      const accountMatch =
        !filterAccount ||
        transaction.fromAccountId === filterAccount ||
        transaction.toAccountId === filterAccount;

      // Filter by currency
      const currencyMatch =
        !filterCurrency ||
        transaction.currency === filterCurrency ||
        transaction.convertedCurrency === filterCurrency;

      return accountMatch && currencyMatch;
    });
  }, [transactions, filterAccount, filterCurrency]);

  return (
    <Layout>
      <TransactionLog
        transactions={filteredTransactions}
        accounts={accounts}
        filterAccount={filterAccount}
        filterCurrency={filterCurrency}
        onFilterAccountChange={setFilterAccount}
        onFilterCurrencyChange={setFilterCurrency}
      />
    </Layout>
  );
};

export default TransferLogsPage;
