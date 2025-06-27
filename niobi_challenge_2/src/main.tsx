import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
  RouterProvider,
} from "react-router-dom";
import "./index.css";

import AccountPage from "./pages/accounts";
import TransferLogsPage from "./pages/tansfer-logs";
import { AppProvider } from "./context";
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";

const approutes = createBrowserRouter(
  createRoutesFromElements(
    <>
      <Route path="/" element={<AccountPage />} />
      <Route path="/transactions" element={<TransferLogsPage />} />
    </>
  )
);
createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <AppProvider>
      <RouterProvider router={approutes} />
    </AppProvider>
  </StrictMode>
);
