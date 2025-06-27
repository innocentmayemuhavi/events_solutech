import styled from "styled-components";
import accountsSvg from "/svg/member-list.svg";
import transactionsSvg from "/svg/radio-button.svg";
import { NavLink, useNavigate } from "react-router-dom";

const StyledHeader = styled.header`
  position: sticky;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  background: white;
  border-bottom: 1px solid var(--gray-300);
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;

  h1{
    cursor: pointer;
`;
const StyledNav = styled.div`
  .nav {
    &-items {
      padding: 7px 16px;
      border-radius: 50px;
      display: flex;
      gap: 16px;
      justify-content: center;

      font-size: 18px;
    }
  }
  @media (max-width: 750px) {
    display: none;
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

const Nav = () => {
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

const Header = () => {
  const navigate = useNavigate();
  return (
    <StyledHeader>
      <h1 onClick={() => navigate("/")}>TMS</h1>
      <Nav />
    </StyledHeader>
  );
};

export default Header;
