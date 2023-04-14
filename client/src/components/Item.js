import { useEffect, useState } from "react";
import "../App.css";

function Item({ urlItem }) {
  return (
    <div className="item">
      Original URL: {urlItem.target_url}
      <div>Shortened URL: {urlItem.slug}</div>
    </div>
  );
}

export default Item;
