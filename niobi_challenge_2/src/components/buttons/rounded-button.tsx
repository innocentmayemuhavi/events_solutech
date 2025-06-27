import styled from "styled-components";

const StyledButton = styled.button`
  border-radius: 12px;
  padding: 0.6em 1.2em;
  font-size: 1em;
  font-weight: 500;
  font-family: inherit;

  cursor: pointer;
  transition: background-color 0.25s;

  &:hover {
    background-color: #646cff;
  }
`;

const RoundedButton = ({
  children,
  onClick,
}: {
  children: React.ReactNode;
  onClick: React.MouseEventHandler<HTMLButtonElement>;
}) => <StyledButton onClick={onClick}>{children}</StyledButton>;

export default RoundedButton;
