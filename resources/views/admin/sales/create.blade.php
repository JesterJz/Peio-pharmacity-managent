@extends('admin.layouts.app')
@push('page-css')
@endpush
@push('page-header')
<div class="col-sm-12">
	<h3 class="page-title">Edit Sale</h3>
	<ul class="breadcrumb">
		<li class="breadcrumb-item"><a href="{{route('dashboard')}}">Dashboard</a></li>
		<li class="breadcrumb-item active">Edit Sale</li>
	</ul>
</div>
@endpush

@section('content')
<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-body custom-edit-service">
                <!-- Create Sale -->
                <form method="POST" action="{{route('sales.store')}}" id="createSalesForm">
					@csrf
					<div class="row form-row">
						<div class="col-md-6">
							<div class="form-group">
								<label>Select Product <span class="text-danger">*</span></label>
								<select class="select2 form-select form-control" name="product">
									<option disabled selected > Select Product</option>
									@foreach ($products as $product)
										@if (!empty($product->purchase))
											@if (!($product->purchase->quantity <= 0))
												<option value="{{$product->id}}">{{$product->purchase->product}}</option>
											@endif
										@endif
									@endforeach
								</select>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Quantity</label>
								<input type="number" value="1" class="form-control" name="quantity">
								<input hidden name="total_price">
							</div>
						</div>
						<div class="col-md-3 d-flex align-items-center pt-1">
							<button type="button" class="btn btn-primary btn-block btn-add">Add</button>
						</div>
					</div>
					{{-- <button type="submit" class="btn btn-primary btn-block">Save Changes</button> --}}
				</form>
                <!--/ Create Sale -->
			</div>
		</div>
	</div>			
</div>
<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-body custom-edit-service">
				<table class="table">
					<thead>
					  <tr>
						<th scope="col">No.</th>
						<th scope="col">Name</th>
						<th scope="col">Quantity</th>
						<th scope="col">Unit Price</th>
						<th scope="col">Total Price</th>
					  </tr>
					</thead>
					<tbody id="rowTable"></tbody>
				</table>
				<div class="d-none price">
					Total Price Orders:   <span id="total_price"></span>VND
				</div>
			</div>
		</div>
	</div>			
</div>
<div class="row">
	<div class="col-md-12 text-center" id="btnSubmit">
	</div>
</div>
@endsection	
@push('page-js')
<script>
	var user_id = JSON.parse({{auth()->user()->id}});
	var day = new Date();
	$( document ).ready(function() {
    	sessionStorage.clear();
		$('.submitFormCreate').click(function () {
			$('#createSalesForm').submit();
		})
	});
	var index = 0;
	const orders = [];
	const dataBlocks = [];
	var total_price_orders = 0;
    $('.btn-add').click(function () {
		var productId = $('select[name=product]').val();
		var quantity = $('input[name=quantity]').val();
		var locahost = window.location.origin;
		axios.get(`${locahost}/api/products/${productId}`).then(function (response) {
            var product = response.data;
			var total_price = product.price * quantity;
			total_price_orders = total_price_orders + total_price;
			var order = {
				name:product.name,
				quantily:quantity,
				price:product.price,
				total_price:total_price,
			}
			index++;
			var html = '<tr><td>'+index+'</td><td>'+product.name+'</td><td>'+quantity+'</td><td>'+product.price+'VND</td><td>'+total_price+'VND</td></tr>';
			$('#rowTable').append(html);
			orders.push(order);
			sessionStorage.setItem('orders', JSON.stringify(orders));
			sessionStorage.setItem('user_id', user_id);
			sessionStorage.setItem('order_id', 32);
			sessionStorage.setItem('total_price_orders', total_price_orders);
			sessionStorage.setItem('created_at', day.toISOString());
			$('.price').removeClass('d-none');
			$('#total_price').text(total_price_orders);
			$('input[name="total_price"]').val(total_price_orders);
        }).catch(function (error) {
           console.log(error);
        });
	});
</script>
@endpush