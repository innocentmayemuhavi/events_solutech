import { useContext, useEffect } from "react";
import Layout from "../../components/layout";
import { AppContext } from "../../context";
import styled from "styled-components";
import AccountCard from "../../components/cards/account-card";

const StyledPage = styled.main`
  padding: 16px 12px;
  .account {
    &-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 16px;

      @media (max-width: 951px) {
        margin-bottom: 20%;
      }
    }
  }
`;

const AccountPage = () => {
  const { accounts } = useContext(AppContext);
  useEffect(() => {
    document.title = "Accounts - Niobi Treasury";
  }, []);
  return (
    <Layout>
      <StyledPage>
        <div className="title-mini">Accounts</div>
        <div className="account-list">
          {accounts.map((account) => (
            <AccountCard key={account.id} account={account} />
          ))}
        </div>
      </StyledPage>
    </Layout>
  );
};

export default AccountPage;
