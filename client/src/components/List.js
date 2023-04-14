import "../App.css";
import "axios";
import axios from "axios";
import { useEffect, useState } from "react";
import Item from "./Item";

function List() {
  const [list, setList] = useState();

  useEffect(() => {
    const loadList = async () => {
      const { data: response } = await axios.get("/urls/analytics");
      setList(response.data);
    };
    loadList().catch((e) => console.error(e));
  }, [list]);

  return (
    <div>
      {list &&
        list.map((item) => {
          return <Item urlItem={item} />;
        })}
    </div>
  );
}

export default List;
