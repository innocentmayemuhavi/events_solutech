import styled from "styled-components";
import accountsSvg from "/svg/member-list.svg";
import transactionsSvg from "/svg/radio-button.svg";
import { NavLink } from "react-router-dom";
const StyledNav = styled.div`
  position: fixed;
  bottom: 2%;
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  .nav {
    &-items {
      background: #fff;
      padding: 5px 10px;
      border-radius: 50px;
      display: flex;
      gap: 16px;
      justify-content: center;
      border: 1px solid var(--gray-300);
      font-size: 18px;
    }
  }
`;

const NavItem = styled.div`
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 1px 6px;

  img {
    width: 24px;
    height: 24px;
  }
`;

const BottomNav = () => {
  return (
    <StyledNav>
      <div className="nav-items">
        <NavLink
          to="/"
          className={({ isActive }) => (isActive ? "active-nav" : "nav")}
        >
          <NavItem>
            {<img src={accountsSvg} alt="Accounts" />}
            <span>Accounts</span>
          </NavItem>
        </NavLink>
        <NavLink
          to="/transactions"
          className={({ isActive }) => (isActive ? "active-nav" : "nav")}
        >
          <NavItem>
            {<img src={transactionsSvg} alt="Transactions" />}
            <span>Transactions</span>
          </NavItem>
        </NavLink>
      </div>
    </StyledNav>
  );
};

export default BottomNav;
