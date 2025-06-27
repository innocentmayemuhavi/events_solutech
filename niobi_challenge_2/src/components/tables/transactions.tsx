import React from "react";
import styled from "styled-components";
import type { Transaction, Account, Currency } from "../../types/treasury";
import {
  CURRENCY_SYMBOLS,
  STATUS_COLORS,
  CURRENCY_COLORS,
} from "../../constants";

const TableContainer = styled.div`
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  margin: 16px 0;
`;

const TableHeader = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid #ecf0f1;
`;

const TableTitle = styled.h2`
  font-size: 1.5rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
`;

const FiltersContainer = styled.div`
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  padding: 16px;
  background: #f8f9fa;
  border-radius: 12px;

  @media (max-width: 768px) {
    flex-direction: column;
    gap: 12px;
  }
`;

const FilterGroup = styled.div`
  flex: 1;
`;

const FilterLabel = styled.label`
  display: block;
  margin-bottom: 6px;
  font-weight: 600;
  color: #2c3e50;
  font-size: 0.9rem;
`;

const FilterSelect = styled.select`
  width: 100%;
  padding: 10px 12px;
  border: 2px solid #ecf0f1;
  border-radius: 8px;
  font-size: 0.9rem;
  font-family: "Quicksand", sans-serif;
  background: white;
  transition: border-color 0.2s ease;

  &:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
  }
`;

const TableWrapper = styled.div`
  overflow-x: auto;
  border-radius: 12px;
  border: 1px solid #ecf0f1;
`;

const Table = styled.div`
  display: grid;
  grid-template-columns:
    100px minmax(180px, 1fr) minmax(150px, 1fr) minmax(120px, auto)
    minmax(160px, auto) minmax(160px, auto) minmax(120px, auto) minmax(120px, 1fr);
  min-width: 1000px;
  font-size: 0.9rem;
`;

const TableHeaderRow = styled.div`
  display: contents;
`;

const HeaderCell = styled.div`
  font-weight: 700;
  color: #2c3e50;
  padding: 16px 12px;
  border-bottom: 2px solid #dee2e6;
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  white-space: nowrap;

  &:first-child {
    border-top-left-radius: 12px;
  }

  &:last-child {
    border-top-right-radius: 12px;
  }
`;

const TableRow = styled.div`
  display: contents;

  &:hover > div {
    background: #f8f9fa;
  }
`;

const TableCell = styled.div`
  padding: 16px 12px;
  border-bottom: 1px solid #ecf0f1;
  display: flex;
  align-items: center;
  background: white;
  transition: background-color 0.2s ease;
  word-wrap: break-word;
  overflow-wrap: break-word;
  min-height: 60px;
  overflow: visible;
  white-space: normal;

  &:first-child {
    border-left: none;
  }

  &:last-child {
    border-right: none;
  }
`;

const TransactionId = styled.div`
  font-family: monospace;
  font-size: 0.8rem;
  color: #7f8c8d;
  background: #ecf0f1;
  padding: 4px 8px;
  border-radius: 6px;
  font-weight: 600;
  white-space: nowrap;
`;

const AccountName = styled.div`
  font-weight: 600;
  color: #2c3e50;
  font-size: 0.9rem;
  line-height: 1.3;
  word-break: break-word;
`;

const Amount = styled.div<{ currency: string }>`
  font-weight: 700;
  color: ${(props) =>
    CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
    "#2c3e50"};
  font-family: "Quicksand", monospace;
  white-space: nowrap;
`;

const Conversion = styled.div`
  font-size: 0.85rem;
  line-height: 1.4;
  width: 100%;

  .converted {
    color: #27ae60;
    font-weight: 600;
    white-space: nowrap;
    margin-bottom: 2px;
  }

  .rate {
    color: #7f8c8d;
    font-size: 0.75rem;
    white-space: nowrap;
  }
`;

const Timestamp = styled.div`
  font-size: 0.8rem;
  color: #7f8c8d;
  line-height: 1.4;
  width: 100%;

  .main-date {
    white-space: nowrap;
    margin-bottom: 2px;
  }

  .scheduled {
    color: #e67e22;
    font-weight: 600;
    white-space: nowrap;
    font-size: 0.75rem;
  }
`;

const StatusBadge = styled.span<{ status: string }>`
  display: inline-block;
  padding: 8px 14px;
  border-radius: 20px;
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  white-space: nowrap;
  background: ${(props) => {
    const color = STATUS_COLORS[props.status as keyof typeof STATUS_COLORS];
    return color ? `${color}20` : "#ecf0f120";
  }};
  color: ${(props) =>
    STATUS_COLORS[props.status as keyof typeof STATUS_COLORS] || "#7f8c8d"};
  border: 2px solid
    ${(props) =>
      STATUS_COLORS[props.status as keyof typeof STATUS_COLORS] || "#ecf0f1"};
  min-width: 80px;
  text-align: center;
`;

const StatusCell = styled(TableCell)`
  justify-content: center;
  padding: 12px 8px;
`;

const Note = styled.div`
  font-style: italic;
  color: #7f8c8d;
  font-size: 0.85rem;
  line-height: 1.3;
  word-break: break-word;
  width: 100%;
`;

const NoTransactions = styled.div`
  text-align: center;
  color: #7f8c8d;
  font-style: italic;
  padding: 60px 20px;
  font-size: 1.1rem;
  background: #f8f9fa;
  border-radius: 12px;
  margin: 20px 0;
`;

const TransactionCount = styled.div`
  color: #7f8c8d;
  font-size: 0.9rem;
  font-weight: 500;
`;

interface TransactionLogProps {
  transactions: Transaction[];
  accounts: Account[];
  filterAccount: string;
  filterCurrency: Currency | "";
  onFilterAccountChange: (value: string) => void;
  onFilterCurrencyChange: (value: Currency | "") => void;
}

const TransactionTable: React.FC<TransactionLogProps> = ({
  transactions,
  accounts,
  filterAccount,
  filterCurrency,
  onFilterAccountChange,
  onFilterCurrencyChange,
}) => {
  const formatDateTime = (date: Date) => {
    return new Intl.DateTimeFormat("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    }).format(date);
  };

  const getStatusBadge = (status: string) => {
    return <StatusBadge status={status}>{status}</StatusBadge>;
  };

  return (
    <TableContainer>
      <TableHeader>
        <TableTitle>Transaction History</TableTitle>
        <TransactionCount>
          {transactions.length} transaction
          {transactions.length !== 1 ? "s" : ""}
        </TransactionCount>
      </TableHeader>

      <FiltersContainer>
        <FilterGroup>
          <FilterLabel htmlFor="filterAccount">Filter by Account:</FilterLabel>
          <FilterSelect
            id="filterAccount"
            value={filterAccount}
            onChange={(e) => onFilterAccountChange(e.target.value)}
          >
            <option value="">All Accounts</option>
            {accounts.map((account) => (
              <option key={account.id} value={account.id}>
                {account.name}
              </option>
            ))}
          </FilterSelect>
        </FilterGroup>

        <FilterGroup>
          <FilterLabel htmlFor="filterCurrency">
            Filter by Currency:
          </FilterLabel>
          <FilterSelect
            id="filterCurrency"
            value={filterCurrency}
            onChange={(e) =>
              onFilterCurrencyChange(e.target.value as Currency | "")
            }
          >
            <option value="">All Currencies</option>
            <option value="KES">KES</option>
            <option value="USD">USD</option>
            <option value="NGN">NGN</option>
          </FilterSelect>
        </FilterGroup>
      </FiltersContainer>

      {transactions.length === 0 ? (
        <NoTransactions>
          No transactions found matching your criteria
        </NoTransactions>
      ) : (
        <>
          <TableWrapper>
            <Table>
              <TableHeaderRow>
                <HeaderCell>ID</HeaderCell>
                <HeaderCell>From</HeaderCell>
                <HeaderCell>To</HeaderCell>
                <HeaderCell>Amount</HeaderCell>
                <HeaderCell>Conversion</HeaderCell>
                <HeaderCell>Date</HeaderCell>
                <HeaderCell>Status</HeaderCell>
                <HeaderCell>Note</HeaderCell>
              </TableHeaderRow>

              {transactions.map((transaction) => (
                <TableRow key={transaction.id}>
                  <TableCell>
                    <TransactionId>{transaction.id.slice(-8)}</TransactionId>
                  </TableCell>
                  <TableCell>
                    <AccountName>{transaction.fromAccountName}</AccountName>
                  </TableCell>
                  <TableCell>
                    <AccountName>{transaction.toAccountName}</AccountName>
                  </TableCell>
                  <TableCell>
                    <Amount currency={transaction.currency}>
                      {CURRENCY_SYMBOLS[transaction.currency]}{" "}
                      {transaction.amount.toLocaleString()}
                    </Amount>
                  </TableCell>
                  <TableCell>
                    <Conversion>
                      {transaction.convertedAmount ? (
                        <div>
                          <div className="converted">
                            → {CURRENCY_SYMBOLS[transaction.convertedCurrency!]}{" "}
                            {transaction.convertedAmount.toLocaleString()}
                          </div>
                          <div className="rate">
                            Rate: {transaction.exchangeRate?.toFixed(6)}
                          </div>
                        </div>
                      ) : (
                        <span style={{ color: "#7f8c8d" }}>Same currency</span>
                      )}
                    </Conversion>
                  </TableCell>
                  <TableCell>
                    <Timestamp>
                      <div className="main-date">
                        {formatDateTime(transaction.timestamp)}
                      </div>
                      {transaction.futureDate && (
                        <div className="scheduled">
                          Scheduled: {formatDateTime(transaction.futureDate)}
                        </div>
                      )}
                    </Timestamp>
                  </TableCell>
                  <StatusCell>{getStatusBadge(transaction.status)}</StatusCell>
                  <TableCell>
                    <Note title={transaction.note || "No note"}>
                      {transaction.note || "-"}
                    </Note>
                  </TableCell>
                </TableRow>
              ))}
            </Table>
          </TableWrapper>
        </>
      )}
    </TableContainer>
  );
};

export default TransactionTable;
