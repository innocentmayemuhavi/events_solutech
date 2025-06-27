import React, { useState, useContext } from "react";
import styled from "styled-components";
import { AppContext } from "../../context";

import { CURRENCY_SYMBOLS, EXCHANGE_RATES } from "../../constants";
import type { Currency } from "../../types/treasury";

const FormContainer = styled.div`
  padding: 24px;
  width: 100%;
  height: 100%;
`;

const FormHeader = styled.div`
  margin-bottom: 32px;
  text-align: center;
`;

const FormTitle = styled.h2`
  font-size: 1.8rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 8px 0;
`;

const FormSubtitle = styled.p`
  color: #7f8c8d;
  margin: 0;
  font-size: 1rem;
`;

const FormGroup = styled.div`
  margin-bottom: 24px;
`;

const Label = styled.label`
  display: block;
  margin-bottom: 8px;
  font-weight: 600;
  color: #2c3e50;
  font-size: 0.9rem;
`;

const Select = styled.select`
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ecf0f1;
  border-radius: 8px;
  font-size: 1rem;
  font-family: "Quicksand", sans-serif;
  background: white;
  transition: border-color 0.2s ease;

  &:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
  }

  &:disabled {
    background: #f8f9fa;
    color: #6c757d;
    cursor: not-allowed;
  }
`;

const Input = styled.input`
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ecf0f1;
  border-radius: 8px;
  font-size: 1rem;
  font-family: "Quicksand", sans-serif;
  transition: border-color 0.2s ease;

  &:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
  }

  &:disabled {
    background: #f8f9fa;
    color: #6c757d;
    cursor: not-allowed;
  }
`;

const HelperText = styled.small`
  display: block;
  margin-top: 4px;
  color: #7f8c8d;
  font-size: 0.85rem;
`;

const ConversionPreview = styled.div`
  background: linear-gradient(135deg, #e8f6ff 0%, #f0f9ff 100%);
  border: 2px solid #3498db;
  border-radius: 12px;
  padding: 16px;
  margin: 16px 0;
`;

const ConversionTitle = styled.h4`
  color: #2980b9;
  margin: 0 0 8px 0;
  font-size: 1rem;
`;

const ConversionDetails = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
`;

const ConversionAmount = styled.span`
  font-weight: 600;
  color: #2c3e50;
`;

const ExchangeRate = styled.small`
  color: #7f8c8d;
  font-size: 0.8rem;
`;

const ButtonGroup = styled.div`
  display: flex;
  gap: 12px;
  margin-top: 32px;
`;

const Button = styled.button<{ variant?: "primary" | "secondary" }>`
  flex: 1;
  padding: 14px 24px;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  font-family: "Quicksand", sans-serif;
  cursor: pointer;
  transition: all 0.2s ease;

  ${(props) =>
    props.variant === "primary"
      ? `
    background: #3498db;
    color: white;
    
    &:hover:not(:disabled) {
      background: #2980b9;
      transform: translateY(-1px);
    }
  `
      : `
    background: #ecf0f1;
    color: #2c3e50;
    
    &:hover:not(:disabled) {
      background: #d5dbdb;
    }
  `}

  &:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none !important;
  }

  &:active:not(:disabled) {
    transform: translateY(0);
  }
`;

const ErrorMessage = styled.div`
  background: #fee2e2;
  border: 2px solid #fca5a5;
  color: #b91c1c;
  padding: 12px 16px;
  border-radius: 8px;
  margin-bottom: 16px;
  font-size: 0.9rem;
`;

const TransferForm: React.FC = () => {
  const { accounts, setAccounts, setModal, setShowModal, setTransactions } =
    useContext(AppContext);

  const [formData, setFormData] = useState({
    fromAccountId: "",
    toAccountId: "",
    amount: "",
    note: "",
    futureDate: "",
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fromAccount = accounts.find((acc) => acc.id === formData.fromAccountId);
  const toAccount = accounts.find((acc) => acc.id === formData.toAccountId);

  const getExchangeRate = (
    fromCurrency: Currency,
    toCurrency: Currency
  ): number => {
    if (fromCurrency === toCurrency) return 1;
    const key = `${fromCurrency}_${toCurrency}` as keyof typeof EXCHANGE_RATES;
    return EXCHANGE_RATES[key] || 1;
  };

  const showConversion =
    fromAccount && toAccount && fromAccount.currency !== toAccount.currency;
  const exchangeRate = showConversion
    ? getExchangeRate(fromAccount.currency, toAccount.currency)
    : 1;
  const convertedAmount = formData.amount
    ? parseFloat(formData.amount) * exchangeRate
    : 0;

  const handleInputChange = (field: string, value: string) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
    setError("");
  };

  const validateForm = (): boolean => {
    if (!formData.fromAccountId || !formData.toAccountId) {
      setError("Please select both source and destination accounts");
      return false;
    }

    if (formData.fromAccountId === formData.toAccountId) {
      setError("Cannot transfer to the same account");
      return false;
    }

    const amount = parseFloat(formData.amount);
    if (!amount || amount <= 0) {
      setError("Please enter a valid amount");
      return false;
    }

    if (fromAccount && fromAccount.balance < amount) {
      setError("Insufficient balance in source account");
      return false;
    }

    return true;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) return;

    setLoading(true);
    setError("");

    try {
      const amount = parseFloat(formData.amount);
      const isScheduled =
        formData.futureDate && new Date(formData.futureDate) > new Date();

      // Create transaction
      const transaction = {
        id: `txn_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        fromAccountId: formData.fromAccountId,
        toAccountId: formData.toAccountId,
        fromAccountName: fromAccount!.name,
        toAccountName: toAccount!.name,
        amount,
        currency: fromAccount!.currency,
        convertedAmount: showConversion ? convertedAmount : undefined,
        convertedCurrency: showConversion ? toAccount!.currency : undefined,
        exchangeRate: showConversion ? exchangeRate : undefined,
        note: formData.note || undefined,
        timestamp: new Date(),
        futureDate: formData.futureDate
          ? new Date(formData.futureDate)
          : undefined,
        status: isScheduled ? ("scheduled" as const) : ("completed" as const),
      };

      // Update accounts if not scheduled
      if (!isScheduled) {
        setAccounts((prevAccounts) =>
          prevAccounts.map((acc) => {
            if (acc.id === formData.fromAccountId) {
              return { ...acc, balance: acc.balance - amount };
            }
            if (acc.id === formData.toAccountId) {
              return { ...acc, balance: acc.balance + convertedAmount };
            }
            return acc;
          })
        );
      }

      // Add transaction
      setTransactions((prev) => [transaction, ...prev]);
      setModal(null);
      setShowModal(false);
    } catch (err) {
      setError("Transfer failed. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  const minDateTime = new Date().toISOString().slice(0, 16);

  return (
    <FormContainer>
      <FormHeader>
        <FormTitle>Transfer Funds</FormTitle>
        <FormSubtitle>Move money between accounts</FormSubtitle>
      </FormHeader>

      {error && <ErrorMessage>{error}</ErrorMessage>}

      <form onSubmit={handleSubmit}>
        <FormGroup>
          <Label htmlFor="fromAccount">From Account</Label>
          <Select
            id="fromAccount"
            value={formData.fromAccountId}
            onChange={(e) => handleInputChange("fromAccountId", e.target.value)}
            disabled={loading}
          >
            <option value="">Select source account</option>
            {accounts.map((account) => (
              <option key={account.id} value={account.id}>
                {account.name} ({account.currency}) -{" "}
                {CURRENCY_SYMBOLS[account.currency]}{" "}
                {account.balance.toLocaleString()}
              </option>
            ))}
          </Select>
        </FormGroup>

        <FormGroup>
          <Label htmlFor="toAccount">To Account</Label>
          <Select
            id="toAccount"
            value={formData.toAccountId}
            onChange={(e) => handleInputChange("toAccountId", e.target.value)}
            disabled={!formData.fromAccountId || loading}
          >
            <option value="">Select destination account</option>
            {accounts
              .filter((account) => account.id !== formData.fromAccountId)
              .map((account) => (
                <option key={account.id} value={account.id}>
                  {account.name} ({account.currency}) -{" "}
                  {CURRENCY_SYMBOLS[account.currency]}{" "}
                  {account.balance.toLocaleString()}
                </option>
              ))}
          </Select>
        </FormGroup>

        <FormGroup>
          <Label htmlFor="amount">Amount</Label>
          <Input
            type="number"
            id="amount"
            value={formData.amount}
            onChange={(e) => handleInputChange("amount", e.target.value)}
            placeholder="Enter amount"
            min="0"
            step="0.01"
            disabled={loading}
          />
          {fromAccount && (
            <HelperText>
              Available: {CURRENCY_SYMBOLS[fromAccount.currency]}{" "}
              {fromAccount.balance.toLocaleString()}
            </HelperText>
          )}
        </FormGroup>

        <FormGroup>
          <Label htmlFor="note">Note (Optional)</Label>
          <Input
            type="text"
            id="note"
            value={formData.note}
            onChange={(e) => handleInputChange("note", e.target.value)}
            placeholder="Transfer description"
            disabled={loading}
          />
        </FormGroup>

        <FormGroup>
          <Label htmlFor="futureDate">Schedule for Future (Optional)</Label>
          <Input
            type="datetime-local"
            id="futureDate"
            value={formData.futureDate}
            onChange={(e) => handleInputChange("futureDate", e.target.value)}
            min={minDateTime}
            disabled={loading}
          />
        </FormGroup>

        {showConversion && formData.amount && (
          <ConversionPreview>
            <ConversionTitle>Currency Conversion</ConversionTitle>
            <ConversionDetails>
              <ConversionAmount>
                {CURRENCY_SYMBOLS[fromAccount!.currency]}{" "}
                {parseFloat(formData.amount).toLocaleString()}→{" "}
                {CURRENCY_SYMBOLS[toAccount!.currency]}{" "}
                {convertedAmount.toLocaleString()}
              </ConversionAmount>
            </ConversionDetails>
            <ExchangeRate>
              Rate: 1 {fromAccount!.currency} = {exchangeRate.toFixed(6)}{" "}
              {toAccount!.currency}
            </ExchangeRate>
          </ConversionPreview>
        )}

        <ButtonGroup>
          <Button
            type="button"
            variant="secondary"
            onClick={() => {
              setModal(null);
              setShowModal(false);
            }}
            disabled={loading}
          >
            Cancel
          </Button>
          <Button
            type="submit"
            variant="primary"
            disabled={
              !formData.fromAccountId ||
              !formData.toAccountId ||
              !formData.amount ||
              loading
            }
          >
            {loading
              ? "Processing..."
              : formData.futureDate &&
                new Date(formData.futureDate) > new Date()
              ? "Schedule Transfer"
              : "Transfer Now"}
          </Button>
        </ButtonGroup>
      </form>
    </FormContainer>
  );
};

export default TransferForm;
