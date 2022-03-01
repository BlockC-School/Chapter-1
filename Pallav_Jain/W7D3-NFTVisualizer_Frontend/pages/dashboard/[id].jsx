import React from "react";
import { useRouter } from "next/router";

export default function id({ datas }) {
  const router = useRouter();
  const id = router.query.id;

  console.log(datas);
  return <div>jjjjjj {id}</div>;
}
