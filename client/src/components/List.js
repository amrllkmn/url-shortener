import "../App.css";
import axios from "axios";
import { useEffect, useState } from "react";
import Item from "./Item";

function List() {
  const [list, setList] = useState(null);

  useEffect(() => {
    const loadList = async () => {
      const { data: response } = await axios.get("/urls/analytics");
      setList(response.data);
    };
    if (!list) {
      loadList().catch((e) => console.error(e));
    }
  }, [list, setList]);
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
