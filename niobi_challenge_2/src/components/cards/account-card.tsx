import styled from "styled-components";
import type { Account } from "../../types/treasury";
import { CURRENCY_SYMBOLS, CURRENCY_COLORS } from "../../constants";

const StyledCard = styled.div<{ currency: string }>`
  background: white;
  border: 1px solid var(--gray-200);
  border-radius: 12px;
  padding: 24px;
  margin: 0;
  cursor: pointer;
  transition: all 0.2s ease;

  border: 1px solid
    ${(props) =>
      CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
      "#3498db"};
`;

const CardHeader = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
`;

const AccountName = styled.h3`
  font-size: 18px;
  font-weight: 900;
  color: var(--gray-900);
  margin: 0;
`;

const CurrencyBadge = styled.span<{ currency: string }>`
  background: ${(props) =>
    (CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
      "#3498db") + "20"};
  color: ${(props) =>
    CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
    "#3498db"};
  border: 1px solid
    ${(props) =>
      (CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
        "#3498db") + "40"};
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.5px;
  flex-shrink: 0;
`;

const BalanceSection = styled.div`
  margin-bottom: 5px;
`;

const BalanceLabel = styled.p`
  font-size: 0.8rem;
  color: var(--gray-600);
  margin: 0 0 4px 0;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
`;

const BalanceAmount = styled.p<{ currency: string }>`
  font-size: 1.5rem;
  font-weight: 700;
  color: ${(props) =>
    CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
    "#3498db"};
  margin: 0;
  line-height: 1.2;
`;

const CardFooter = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 5px;
  border-top: 1px solid var(--gray-200);
`;

const AccountId = styled.span`
  font-size: 1rem;
  color: var(--gray-500);
  font-family: monospace;
  background: var(--gray-100);
  padding: 4px 8px;
  border-radius: 4px;
  font-weight: 500;
`;

const StatusDot = styled.div<{ currency: string }>`
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: ${(props) =>
    CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
    "#3498db"};
  position: relative;

  &::after {
    content: "";
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    border-radius: 50%;
    border: 2px solid
      ${(props) =>
        CURRENCY_COLORS[props.currency as keyof typeof CURRENCY_COLORS] ||
        "#3498db"};
    opacity: 0.3;
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0% {
      transform: scale(1);
    }
    50% {
      transform: scale(1.2);
    }
    100% {
      transform: scale(1);
    }
  }
`;

const AccountCard = ({ account }: { account: Account }) => {
  const formatBalance = (amount: number, currency: string) => {
    const symbol =
      CURRENCY_SYMBOLS[currency as keyof typeof CURRENCY_SYMBOLS] || currency;
    return `${symbol}${amount.toLocaleString()}`;
  };

  return (
    <StyledCard currency={account.currency}>
      <CardHeader>
        <AccountName>{account.name}</AccountName>
        <CurrencyBadge currency={account.currency}>
          {account.currency}
        </CurrencyBadge>
      </CardHeader>

      <BalanceSection>
        <BalanceLabel>Available Balance</BalanceLabel>
        <BalanceAmount currency={account.currency}>
          {formatBalance(account.balance, account.currency)}
        </BalanceAmount>
      </BalanceSection>

      <CardFooter>
        <AccountId> # {account.id}</AccountId>
        <StatusDot currency={account.currency} title="Active" />
      </CardFooter>
    </StyledCard>
  );
};

export default AccountCard;
