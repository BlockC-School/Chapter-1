import React, { useEffect, useState } from "react";
import { useRouter } from "next/router";
import axios from "axios";
import Card from "@mui/material/Card";
import Link from "next/link";
import styles from "../../styles/Home.module.css";
// import Particle from "../Particle";

export default function index() {
  const [data, setData] = useState([]);
  const router = useRouter();


  const name = "pallab"

  const {
    query: { name, baseURI, tokenCount, Address, MarvelCollection },
  } = router;
  console.log("baseURI:", MarvelCollection);

  useEffect(() => {
    (async () => {
      if (baseURI && tokenCount > 0) {
        let accounts = Array(tokenCount).fill(Address);
        let ids = Array.from({ length: tokenCount }, (_, i) => i + 1);
        // const _balances = await MarvelCollection.balanceOfBatch(accounts, ids);
        // console.log("_balances:", _balances);

        let datas = [];

        for (let i = 1; i <= tokenCount; i++) {
          const { data } = await axios.get(`${baseURI}${i}.json`);
          //   data.amount = _balances[i - 1].toNumber();
          data.tokenId = i;

          datas.push(data);

          // console.log("data:", data);
        }
        setData(datas);
      }
    })();
  }, [baseURI, tokenCount]);

  console.log(data);

  return (
    <div>
      {/* <Particle /> */}
      {data.map((e) => (
        <Link href={`/dashboard/${e.tokenId}`}>
          <Card variant="outlined" key={e.tokenId} className={styles.card}>
            <img
              style={{ width: "200px", height: "300px" }}
              src={e.image}
              alt=""
            />
            <p>{name}</p>
            <strong>{e.name}</strong>
            <hr />
            <p>x{e.amount}</p>
          </Card>
        </Link>
      ))}
    </div>
  );
}
