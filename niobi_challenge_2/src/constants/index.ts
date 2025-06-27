import type { Currency, ExchangeRates, Account } from "../types/treasury";

export const CURRENCIES: Currency[] = ['KES', 'USD', 'NGN'];

export const CURRENCY_SYMBOLS = {
    KES: 'KSh',
    USD: '$',
    NGN: '₦'
} as const;

export const CURRENCY_NAMES = {
    KES: 'Kenyan Shilling',
    USD: 'US Dollar',
    NGN: 'Nigerian Naira'
} as const;

export const EXCHANGE_RATES: ExchangeRates = {
    KES_USD: 0.0077,
    KES_NGN: 0.075,
    USD_KES: 130,
    USD_NGN: 1500,
    NGN_KES: 0.087,
    NGN_USD: 0.00067
};

export const EXCHANGE_RATE_UPDATE_INTERVAL = 15;

export const INITIAL_ACCOUNTS: Account[] = [
    { id: '1', name: 'Mpesa_KES_1', currency: 'KES', balance: 500000 },
    { id: '2', name: 'Bank_KES_1', currency: 'KES', balance: 1200000 },
    { id: '3', name: 'Equity_KES_2', currency: 'KES', balance: 800000 },
    { id: '4', name: 'KCB_KES_3', currency: 'KES', balance: 2000000 },
    { id: '5', name: 'Chase_USD_1', currency: 'USD', balance: 15000 },
    { id: '6', name: 'Bank_USD_2', currency: 'USD', balance: 25000 },
    { id: '7', name: 'Wells_USD_3', currency: 'USD', balance: 8000 },
    { id: '8', name: 'GTBank_NGN_1', currency: 'NGN', balance: 5000000 },
    { id: '9', name: 'First_NGN_2', currency: 'NGN', balance: 3500000 },
    { id: '10', name: 'Access_NGN_3', currency: 'NGN', balance: 7200000 }
];

export const ACCOUNT_TYPES = {
    MOBILE_MONEY: 'mobile_money',
    COMMERCIAL_BANK: 'commercial_bank',
    INVESTMENT_BANK: 'investment_bank',
    DIGITAL_WALLET: 'digital_wallet'
} as const;

export const ACCOUNT_PROVIDERS = {
    KES: ['Mpesa', 'Bank', 'Equity', 'KCB', 'Coop Bank', 'NCBA'],
    USD: ['Chase', 'Bank', 'Wells', 'Citibank', 'HSBC', 'Standard'],
    NGN: ['GTBank', 'First', 'Access', 'Zenith', 'UBA', 'Stanbic']
} as const;

export const TRANSACTION_STATUS = {
    COMPLETED: 'completed',
    PENDING: 'pending',
    SCHEDULED: 'scheduled',
    FAILED: 'failed',
    CANCELLED: 'cancelled'
} as const;

export const TRANSACTION_TYPES = {
    TRANSFER: 'transfer',
    DEPOSIT: 'deposit',
    WITHDRAWAL: 'withdrawal',
    EXCHANGE: 'exchange',
    FEE: 'fee'
} as const;

export const MAX_TRANSFER_AMOUNTS = {
    KES: 10000000,
    USD: 100000,
    NGN: 50000000
} as const;

export const MIN_TRANSFER_AMOUNTS = {
    KES: 1,
    USD: 0.01,
    NGN: 1
} as const;

export const TRANSACTION_FEES = {
    SAME_CURRENCY: 0.001,
    CROSS_CURRENCY: 0.0025,
    INTERNATIONAL: 0.005
} as const;

export const THEME_COLORS = {
    PRIMARY: '#3498db',
    SECONDARY: '#2c3e50',
    SUCCESS: '#27ae60',
    WARNING: '#f39c12',
    DANGER: '#e74c3c',
    INFO: '#17a2b8',
    LIGHT: '#f8f9fa',
    DARK: '#343a40'
} as const;

export const CURRENCY_COLORS = {
    KES: '#27ae60',
    USD: '#3498db',
    NGN: '#e74c3c'
} as const;

export const STATUS_COLORS = {
    completed: '#27ae60',
    pending: '#f39c12',
    scheduled: '#e17055',
    failed: '#e74c3c',
    cancelled: '#95a5a6'
} as const;

export const VALIDATION_RULES = {
    ACCOUNT_NAME: {
        MIN_LENGTH: 3,
        MAX_LENGTH: 50,
        PATTERN: /^[a-zA-Z0-9_\-\s]+$/
    },
    TRANSFER_NOTE: {
        MAX_LENGTH: 200
    },
    AMOUNT: {
        DECIMAL_PLACES: 2,
        MIN_VALUE: 0.01
    }
} as const;

export const DATE_FORMATS = {
    DISPLAY: 'MMM dd, yyyy HH:mm:ss',
    ISO: 'yyyy-MM-dd\'T\'HH:mm:ss',
    SHORT: 'MMM dd, yyyy',
    TIME_ONLY: 'HH:mm:ss'
} as const;

export const TIMEZONE = 'Africa/Nairobi';

export const SCHEDULING_LIMITS = {
    MIN_FUTURE_MINUTES: 5,
    MAX_FUTURE_DAYS: 365
} as const;

export const API_ENDPOINTS = {
    ACCOUNTS: '/api/accounts',
    TRANSACTIONS: '/api/transactions',
    EXCHANGE_RATES: '/api/exchange-rates',
    TRANSFER: '/api/transfer'
} as const;

export const HTTP_STATUS = {
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    FORBIDDEN: 403,
    NOT_FOUND: 404,
    INTERNAL_SERVER_ERROR: 500
} as const;

export const PAGINATION = {
    DEFAULT_PAGE_SIZE: 10,
    MAX_PAGE_SIZE: 100,
    TRANSACTION_PAGE_SIZE: 25
} as const;

export const NUMBER_FORMATS = {
    CURRENCY: {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    },
    EXCHANGE_RATE: {
        minimumFractionDigits: 2,
        maximumFractionDigits: 6
    },
    PERCENTAGE: {
        style: 'percent',
        minimumFractionDigits: 1,
        maximumFractionDigits: 2
    }
} as const;

export const ERROR_MESSAGES = {
    INSUFFICIENT_FUNDS: 'Insufficient balance in source account',
    INVALID_AMOUNT: 'Please enter a valid amount',
    SAME_ACCOUNT: 'Cannot transfer to the same account',
    ACCOUNT_NOT_FOUND: 'Account not found',
    NETWORK_ERROR: 'Network error. Please try again.',
    VALIDATION_ERROR: 'Please check your input and try again',
    UNAUTHORIZED: 'You are not authorized to perform this action',
    SERVER_ERROR: 'Server error. Please try again later.'
} as const;

export const SUCCESS_MESSAGES = {
    TRANSFER_COMPLETED: 'Transfer completed successfully',
    TRANSFER_SCHEDULED: 'Transfer scheduled successfully',
    ACCOUNT_UPDATED: 'Account updated successfully',
    DATA_SAVED: 'Data saved successfully'
} as const;

export const LOADING_MESSAGES = {
    PROCESSING_TRANSFER: 'Processing transfer...',
    LOADING_ACCOUNTS: 'Loading accounts...',
    LOADING_TRANSACTIONS: 'Loading transactions...',
    UPDATING_RATES: 'Updating exchange rates...'
} as const;

export const STORAGE_KEYS = {
    ACCOUNTS: 'treasury_accounts',
    TRANSACTIONS: 'treasury_transactions',
    EXCHANGE_RATES: 'treasury_exchange_rates',
    USER_PREFERENCES: 'treasury_preferences'
} as const;

export const FEATURES = {
    ENABLE_FUTURE_TRANSFERS: true,
    ENABLE_TRANSACTION_FEES: false,
    ENABLE_MULTI_CURRENCY: true,
    ENABLE_NOTIFICATIONS: true,
    ENABLE_EXPORT: false
} as const;

export const BUSINESS_RULES = {
    MAX_DAILY_TRANSFERS: 50,
    MAX_DAILY_AMOUNT_USD: 100000,
    REQUIRE_APPROVAL_ABOVE_USD: 10000,
    AUTO_SCHEDULE_CUTOFF_HOUR: 17,
    WEEKEND_PROCESSING: false
} as const;

export default {
    CURRENCIES,
    CURRENCY_SYMBOLS,
    CURRENCY_NAMES,
    EXCHANGE_RATES,
    INITIAL_ACCOUNTS,
    ACCOUNT_TYPES,
    ACCOUNT_PROVIDERS,
    TRANSACTION_STATUS,
    TRANSACTION_TYPES,
    MAX_TRANSFER_AMOUNTS,
    MIN_TRANSFER_AMOUNTS,
    TRANSACTION_FEES,
    THEME_COLORS,
    CURRENCY_COLORS,
    STATUS_COLORS,
    VALIDATION_RULES,
    DATE_FORMATS,
    TIMEZONE,
    SCHEDULING_LIMITS,
    API_ENDPOINTS,
    HTTP_STATUS,
    PAGINATION,
    NUMBER_FORMATS,
    ERROR_MESSAGES,
    SUCCESS_MESSAGES,
    LOADING_MESSAGES,
    STORAGE_KEYS,
    FEATURES,
    BUSINESS_RULES
}