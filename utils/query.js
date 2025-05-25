import db from "../database/index.js";

export const query = async (query, array) => {
  const [value] = await db.query(query, array === undefined ? [] : array);
  return value;
};

export const queryBulk = async (query, array) => {
  return await db.format(query, array === undefined ? [] : array);
};
