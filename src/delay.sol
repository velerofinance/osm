/// delay.sol - value that is activated after a timed delay

// Copyright (C) 2018  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.20;

import "ds-value/value.sol";
import "ds-warp/warp.sol";

contract DSDelay is DSValue {
    DSValue public src;
    
    bytes32 public nxt;
    uint64  public zzz;

    uint constant ONE_HOUR = 3600;

    function DSDelay(DSValue src_) public {
        src = src_;
        bytes32 wut;
        bool ok;
        (wut, ok) = src_.peek();
        if (ok) {
            val = wut;
            has = true;
            nxt = wut;
            zzz = prev(now);
        }
    }

    function prev(uint ts) internal pure returns (uint64) {
        return uint64(ts - (ts % ONE_HOUR));
    }

    function next(uint ts) internal pure returns (uint64) {
        return uint64(prev(ts) + ONE_HOUR);
    }

    function poke() external returns (bool) {
        if (now >= next(zzz)) {
            bytes32 wut;
            bool ok;
            (wut, ok) = src.peek();
            if (ok) {
                this.poke(nxt);
                nxt = wut;
                zzz = prev(now);
            } else {
                this.void();
            }
            return true;
        }
        return false;
    }
}
