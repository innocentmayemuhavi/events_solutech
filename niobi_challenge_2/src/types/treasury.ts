export type Currency = 'KES' | 'USD' | 'NGN';

export interface Account {
    id: string;
    name: string;
    currency: Currency;
    balance: number;
}

export interface Transaction {
    id: string;
    fromAccountId: string;
    toAccountId: string;
    fromAccountName: string;
    toAccountName: string;
    amount: number;
    currency: Currency;
    convertedAmount?: number;
    convertedCurrency?: Currency;
    exchangeRate?: number;
    note?: string;
    timestamp: Date;
    futureDate?: Date;
    status: 'completed' | 'pending' | 'scheduled';
}

export interface ExchangeRates {
    KES_USD: number;
    KES_NGN: number;
    USD_KES: number;
    USD_NGN: number;
    NGN_KES: number;
    NGN_USD: number;
}