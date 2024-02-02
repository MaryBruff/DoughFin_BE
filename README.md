# DoughFin_BE

## Introduction
DoughFin is a user-friendly financial management app designed to help individuals effortlessly track their income, categorize expenses, and create budgets. With DoughFin, managing your finances becomes intuitive, empowering you to make informed decisions about your money.

## Features
**Income Tracking:** Automatically track your income from various sources to see how much you're earning.<br>
**Expense Categorization:** Automatically categorize your expenses for a clearer understanding of your spending habits.<br>
**Budget Creation:** Set up personalized budgets to control your spending and achieve your financial goals.<br>
**Insightful Reports:** Get detailed reports and insights into your financial health, helping you make better financial decisions.<br>
**Secure Account Linking:** Safely link your bank account(s) for real-time transaction updates.

## Endpoint Testing
[Postman Environment](https://turing-school-of-software-and-design-student-plan-team-2.postman.co/workspace/8ddf4dac-97e4-442b-8e86-5b3d49e18134)

## Database Schema
<img width="750" alt="Screenshot 2024-02-02 at 16 09 48" src="https://github.com/DoughFin/DoughFin_BE/assets/25095319/ecd61e9c-aa9a-4734-8326-73826470f102">

## GraphQl Contract
```markdown
type Query {
  user(id: ID!): User
  users: [User]
  incomeRecords(userId: ID!): [Income]
  expenseRecords(userId: ID!): [Expense]
}

type User {
  id: ID!
  username: String!
  email: String!
  incomes: [Income]
  expenses: [Expense]
}

type Income {
  id: ID!
  user: User!
  source: String!
  amount: Float!
  date: String! # ISO 8601 Date format, could also use a custom DateTime scalar type
}

type Expense {
  id: ID!
  user: User!
  category: String!
  amount: Float!
  date: String! # ISO 8601 Date format, could also use a custom DateTime scalar type
}

type Mutation {
  createUser(username: String!, email: String!, password: String!): User
  addIncome(userId: ID!, source: String!, amount: Float!, date: String!): Income
  addExpense(userId: ID!, category: String!, amount: Float!, date: String!): Expense
  # Add more mutations for updating and deleting records as needed
}
```

## Acknowledgments
Thank you to all the contributors who have helped shape DoughFin.
Special thanks to our users for trusting us with their financial management needs.
